import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_flutter/pull_refresh/src/indicator/simple_text.dart';

import 'direction_helper.dart';

typedef FPullRefreshStateChangeCallback = void Function(
    FPullRefreshState state);

typedef FPullRefreshDirectionChangeCallback = void Function(
    FPullRefreshDirection direction);

enum FPullRefreshState {
  /// 空闲
  idle,

  /// 下拉刷新，还未达到可以刷新的条件
  pullRefresh,

  /// 松开刷新，已经达到可以刷新的条件
  releaseRefresh,

  /// 刷新中
  refresh,

  /// 展示刷新结果
  refreshResult,

  /// 刷新结束，如果未做任何操作，在动画结束后，回到[FPullRefreshState.idle]状态
  refreshFinish,
}

enum FPullRefreshDirection {
  none,
  top,
  bottom,
}

abstract class FPullRefreshIndicator {
  Widget build(
    BuildContext context,
    FPullRefreshState state,
  );

  double getRefreshSize() {
    return null;
  }
}

class FPullRefreshController {
  FPullRefreshState _state = FPullRefreshState.idle;
  FPullRefreshDirection _refreshDirection = FPullRefreshDirection.none;

  dynamic _refreshResult;

  final List<FPullRefreshStateChangeCallback> _listStateChangeCallback = [];
  final List<FPullRefreshDirectionChangeCallback> _listDirectionChangeCallback =
      [];

  Timer _stopRefreshTimer;

  FPullRefreshState get state => _state;

  FPullRefreshDirection get refreshDirection => _refreshDirection;

  dynamic get refreshResult => _refreshResult;

  /// 添加状态变化回调
  void addStateChangeCallback(FPullRefreshStateChangeCallback callback) {
    if (callback == null || _listStateChangeCallback.contains(callback)) {
      return;
    }
    _listStateChangeCallback.add(callback);
  }

  /// 移除状态变化回调
  void removeStateChangeCallback(FPullRefreshStateChangeCallback callback) {
    _listStateChangeCallback.remove(callback);
  }

  /// 添加方向变化回调
  void addDirectionChangeCallback(
      FPullRefreshDirectionChangeCallback callback) {
    if (callback == null || _listDirectionChangeCallback.contains(callback)) {
      return;
    }
    _listDirectionChangeCallback.add(callback);
  }

  /// 移除方向变化回调
  void removeDirectionChangeCallback(
      FPullRefreshDirectionChangeCallback callback) {
    _listDirectionChangeCallback.remove(callback);
  }

  /// 触发刷新
  void startRefresh(FPullRefreshDirection direction) {
    assert(direction != null);
    assert(direction != FPullRefreshDirection.none);
    if (_state == FPullRefreshState.idle) {
      _setDirection(FPullRefreshDirection.top);
      _setState(FPullRefreshState.refresh);
      _updateUIByState();
    }
  }

  /// 停止刷新
  void stopRefresh({dynamic result}) {
    if (result != null) {
      if (_state == FPullRefreshState.refresh) {
        _refreshResult = result;
        _setState(FPullRefreshState.refreshResult);
        _updateUIByState();
      }
    } else {
      if (_state == FPullRefreshState.refresh ||
          _state == FPullRefreshState.refreshResult) {
        _setState(FPullRefreshState.refreshFinish);
        _updateUIByState();
      }
    }
  }

  void _notifyStateChangeCallback(FPullRefreshState state) {
    if (_listStateChangeCallback.isEmpty) {
      return;
    }

    final List<FPullRefreshStateChangeCallback> listCopy =
        List.from(_listStateChangeCallback);

    listCopy.forEach((item) {
      item(state);
    });
  }

  void _notifyDirectionChangeCallback(FPullRefreshDirection direction) {
    if (_listDirectionChangeCallback.isEmpty) {
      return;
    }

    final List<FPullRefreshDirectionChangeCallback> listCopy =
        List.from(_listDirectionChangeCallback);

    listCopy.forEach((item) {
      item(direction);
    });
  }

  void _setState(FPullRefreshState state) {
    assert(state != null);

    final FPullRefreshState old = _state;
    if (old == state) {
      return;
    }

    assert(_refreshDirection != FPullRefreshDirection.none);

    _state = state;

    print('$runtimeType----- _setState: $state');

    if (_stopRefreshTimer != null) {
      _stopRefreshTimer.cancel();
      _stopRefreshTimer = null;
    }
    if (state == FPullRefreshState.refreshResult) {
      _stopRefreshTimer = Timer(Duration(milliseconds: 600), () {
        stopRefresh();
      });
    }

    _notifyStateChangeCallback(state);

    if (state == FPullRefreshState.idle) {
      _refreshResult = null;
    }
  }

  void _setDirection(FPullRefreshDirection direction) {
    assert(direction != null);
    assert(_state == FPullRefreshState.idle);

    if (_refreshDirection != direction) {
      _refreshDirection = direction;

      print('$runtimeType-----  _setDirection: $direction');

      _notifyDirectionChangeCallback(direction);
    }
  }

  void _updateUIByState() {}

  Widget newWidget({
    @required Widget child,
    FPullRefreshIndicator indicatorTop,
  }) {
    return _PullRefreshView(
      controller: this,
      child: child,
      indicatorTop: indicatorTop,
    );
  }
}

class _PullRefreshView extends StatefulWidget {
  final FPullRefreshController controller;

  final Widget child;
  final FPullRefreshIndicator indicatorTop;

  _PullRefreshView({
    @required this.controller,
    @required this.child,
    FPullRefreshIndicator indicatorTop,
  })  : assert(controller != null),
        this.indicatorTop = indicatorTop ?? FSimpleTextPullRefreshIndicator();

  @override
  _PullRefreshViewState createState() => _PullRefreshViewState();
}

class _PullRefreshViewState extends State<_PullRefreshView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  DirectionHelper _topHelper;

  FPullRefreshController get controller {
    return widget.controller;
  }

  @override
  void initState() {
    super.initState();
    _topHelper = TopDirectionHelper(widget.indicatorTop);

    _animationController = AnimationController(
      value: 0.0,
      vsync: this,
      lowerBound: -1000,
      upperBound: 1000,
    );

    _animationController.addStatusListener((status) {
      print('$runtimeType AnimationStatus: $status');
    });

    _animationController.addListener(() {
      print('$runtimeType AnimationValue: ${_animationController.value}');
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  DirectionHelper get currentHelper {
    switch (controller.refreshDirection) {
      case FPullRefreshDirection.top:
        return _topHelper;
      case FPullRefreshDirection.bottom:
        return null;
      default:
        return null;
    }
  }

  double get offset {
    return _animationController.value;
  }

  void _updateOffset(double delta) {
    final double targetOffset = offset + delta;

    print('$runtimeType----- targetOffset: $targetOffset');

    final double refreshSize = currentHelper.getRefreshSize();
    if (targetOffset.abs() >= refreshSize) {
      if (controller.state == FPullRefreshState.pullRefresh) {
        controller._setState(FPullRefreshState.releaseRefresh);
      }
    } else {
      if (controller.state == FPullRefreshState.releaseRefresh) {
        controller._setState(FPullRefreshState.pullRefresh);
      }
    }

    _animationController.value = targetOffset;
  }

  bool _canPull(ScrollNotification notification) {
    return controller.state == FPullRefreshState.idle;
  }

  bool _isDrag() {
    return controller.state == FPullRefreshState.pullRefresh ||
        controller.state == FPullRefreshState.releaseRefresh;
  }

  bool _handleNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
    } else if (notification is UserScrollNotification) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          if (_canPull(notification)) {
            if (notification.metrics.extentBefore == 0.0 &&
                _topHelper.getIndicatorSize() != null) {
              controller._setDirection(FPullRefreshDirection.top);
              controller._setState(FPullRefreshState.pullRefresh);
            }
          }
          break;
        case ScrollDirection.reverse:
          break;
        case ScrollDirection.idle:
          if (controller.state == FPullRefreshState.releaseRefresh) {
            controller._setState(FPullRefreshState.refresh);
            scrollByState();
          }
          break;
      }
    } else if (notification is OverscrollNotification) {
      if (_isDrag()) {
        _updateOffset(notification.dragDetails.primaryDelta / 3);
      }
    } else if (notification is ScrollUpdateNotification) {
      if (_isDrag()) {
        _updateOffset(-notification.scrollDelta / 2);
      }
    } else if (notification is ScrollEndNotification) {}

    return false;
  }

  void scrollByState() {
    switch (controller.state) {
      case FPullRefreshState.idle:
        // TODO: Handle this case.
        break;
      case FPullRefreshState.pullRefresh:
        // TODO: Handle this case.
        break;
      case FPullRefreshState.releaseRefresh:
        // TODO: Handle this case.
        break;
      case FPullRefreshState.refresh:
        final double targetOffset = currentHelper.getRefreshOffset();

        _animationController.animateTo(targetOffset,
            duration: Duration(seconds: 1));
        break;
      case FPullRefreshState.refreshResult:
        // TODO: Handle this case.
        break;
      case FPullRefreshState.refreshFinish:
        // TODO: Handle this case.
        break;
    }
  }

  Widget _buildTop(BuildContext context) {
    Widget widget = _topHelper.newWidget(context, controller.state);
    final double targetOffset = _topHelper.getIndicatorOffset(offset);

    widget = Transform.translate(
      offset: Offset(0.0, targetOffset),
      child: widget,
    );

    return widget;
  }

  Widget _buildChild() {
    return Transform.translate(
      offset: Offset(0.0, offset),
      child: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget widgetTop = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return _buildTop(context);
      },
    );

    Widget widgetChild = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return _buildChild();
      },
    );

    final List<Widget> list = [];
    list.add(widgetChild);
    list.add(widgetTop);

    Widget result = Stack(
      children: list,
    );

    result = NotificationListener<ScrollNotification>(
      child: result,
      onNotification: _handleNotification,
    );

    return result;
  }
}
