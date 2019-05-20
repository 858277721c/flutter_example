import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_flutter/pull_refresh/src/indicator/simple_text.dart';

import 'direction_helper.dart';

typedef FPullRefreshCallback = void Function(FPullRefreshDirection direction);

typedef FPullRefreshStateChangeCallback = void Function(
    FPullRefreshState state);

typedef FPullRefreshDirectionChangeCallback = void Function(
    FPullRefreshDirection direction);

enum FPullRefreshState {
  /// 空闲状态
  idle,

  /// 下拉刷新，还未达到可以刷新的条件
  pullRefresh,

  /// 松开刷新，已经达到可以刷新的条件
  releaseRefresh,

  /// 刷新中
  refresh,

  /// 展示刷新结果
  refreshResult,

  /// 结束状态，如果未做任何操作，在动画结束后，回到[FPullRefreshState.idle]状态
  finish,
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

const Duration _kMaxDuration = const Duration(milliseconds: 150);
const Duration _kMinDuration = const Duration(milliseconds: 50);
const String _kLogTag = 'FPullRefresh----- ';

//---------- Controller ----------

abstract class FPullRefreshController {
  factory FPullRefreshController() {
    return _SimplePullRefreshController();
  }

  FPullRefreshState get state;

  dynamic get refreshResult;

  bool get overlayMode;

  void set overlayMode(bool overlay);

  /// 设置刷新回调
  void setRefreshCallback(FPullRefreshCallback callback);

  /// 添加状态变化回调
  void addStateChangeCallback(FPullRefreshStateChangeCallback callback);

  /// 移除状态变化回调
  void removeStateChangeCallback(FPullRefreshStateChangeCallback callback);

  /// 添加方向变化回调
  void addDirectionChangeCallback(FPullRefreshDirectionChangeCallback callback);

  /// 移除方向变化回调
  void removeDirectionChangeCallback(
      FPullRefreshDirectionChangeCallback callback);

  /// 触发刷新
  void startRefresh(FPullRefreshDirection direction);

  /// 停止刷新
  void stopRefresh({dynamic result});

  /// 创建一个刷新Widget
  Widget newRefreshWidget({
    @required Widget child,
    FPullRefreshIndicator indicatorTop,
  });
}

class _SimplePullRefreshController implements FPullRefreshController {
  FPullRefreshState _state = FPullRefreshState.idle;
  FPullRefreshDirection _refreshDirection = FPullRefreshDirection.none;

  bool _overlayMode = false;
  dynamic _refreshResult;
  Timer _stopRefreshTimer;

  FPullRefreshCallback _refreshCallback;
  final List<FPullRefreshStateChangeCallback> _listStateChangeCallback = [];
  final List<FPullRefreshDirectionChangeCallback> _listDirectionChangeCallback =
      [];

  @override
  FPullRefreshState get state => _state;

  @override
  dynamic get refreshResult => _refreshResult;

  @override
  bool get overlayMode => _overlayMode;

  @override
  void set overlayMode(bool overlay) {
    assert(overlay != null);
    assert(_state == FPullRefreshState.idle,
        'overlayMode can only changed in FPullRefreshState.idle state');
    _overlayMode = overlay;
  }

  @override
  void setRefreshCallback(FPullRefreshCallback callback) {
    _refreshCallback = callback;
  }

  @override
  void addStateChangeCallback(FPullRefreshStateChangeCallback callback) {
    if (callback == null || _listStateChangeCallback.contains(callback)) {
      return;
    }
    _listStateChangeCallback.add(callback);
  }

  @override
  void removeStateChangeCallback(FPullRefreshStateChangeCallback callback) {
    _listStateChangeCallback.remove(callback);
  }

  @override
  void addDirectionChangeCallback(
      FPullRefreshDirectionChangeCallback callback) {
    if (callback == null || _listDirectionChangeCallback.contains(callback)) {
      return;
    }
    _listDirectionChangeCallback.add(callback);
  }

  @override
  void removeDirectionChangeCallback(
      FPullRefreshDirectionChangeCallback callback) {
    _listDirectionChangeCallback.remove(callback);
  }

  @override
  void startRefresh(FPullRefreshDirection direction) {
    assert(direction != null);
    assert(direction != FPullRefreshDirection.none);
    if (_state == FPullRefreshState.idle) {
      _setDirection(FPullRefreshDirection.top);
      _setState(FPullRefreshState.refresh);
    }
  }

  @override
  void stopRefresh({dynamic result}) {
    if (result != null) {
      if (_state == FPullRefreshState.refresh) {
        _refreshResult = result;
        _setState(FPullRefreshState.refreshResult);
      }
    } else {
      if (_state == FPullRefreshState.refresh ||
          _state == FPullRefreshState.refreshResult) {
        _setState(FPullRefreshState.finish);
      }
    }
  }

  @override
  Widget newRefreshWidget({
    @required Widget child,
    FPullRefreshIndicator indicatorTop,
  }) {
    return _PullRefreshView(
      controller: this,
      child: child,
      indicatorTop: indicatorTop,
    );
  }

  void _notifyRefreshCallback() {
    assert(_state == FPullRefreshState.refresh);
    print(_kLogTag + 'notifyRefreshCallback');

    if (_refreshCallback != null) {
      _refreshCallback(_refreshDirection);
    }
  }

  void _notifyStateChangeCallback(FPullRefreshState state) {
    if (_listStateChangeCallback.isNotEmpty) {
      List.from(_listStateChangeCallback).forEach((item) {
        item(state);
      });
    }
  }

  void _notifyDirectionChangeCallback(FPullRefreshDirection direction) {
    if (_listDirectionChangeCallback.isNotEmpty) {
      final List<FPullRefreshDirectionChangeCallback> listCopy =
          List.from(_listDirectionChangeCallback);

      listCopy.forEach((item) {
        item(direction);
      });
    }
  }

  void _setState(FPullRefreshState state) {
    assert(state != null);
    assert(_refreshDirection != FPullRefreshDirection.none);

    final FPullRefreshState old = _state;
    if (old == state) {
      return;
    }

    _state = state;

    print(_kLogTag + 'setState: $state');

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
      _setDirection(FPullRefreshDirection.none);
    }
  }

  void _setDirection(FPullRefreshDirection direction) {
    assert(direction != null);
    assert(_state == FPullRefreshState.idle);

    if (_refreshDirection != direction) {
      _refreshDirection = direction;

      print(_kLogTag + 'setDirection: $direction');
      _notifyDirectionChangeCallback(direction);
    }
  }
}

//---------- View ----------

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
  bool _isDrag = false;
  final GlobalKey _notificationKey = GlobalKey();

  _SimplePullRefreshController get controller {
    return widget.controller;
  }

  DirectionHelper get currentHelper {
    switch (controller._refreshDirection) {
      case FPullRefreshDirection.top:
        return _topHelper;
      case FPullRefreshDirection.bottom:
        return null;
      default:
        return null;
    }
  }

  double get currentOffset {
    return _animationController.value;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
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
      if (status == AnimationStatus.completed) {
        switch (controller.state) {
          case FPullRefreshState.refresh:
            controller._notifyRefreshCallback();
            break;
          case FPullRefreshState.finish:
            controller._setState(FPullRefreshState.idle);
            break;
          default:
            break;
        }
      }
    });

    controller.addStateChangeCallback(_stateChangeCallback);
    controller.addDirectionChangeCallback(_directionChangeCallback);
  }

  @override
  void dispose() {
    controller.removeStateChangeCallback(_stateChangeCallback);
    controller.removeDirectionChangeCallback(_directionChangeCallback);
    _animationController.dispose();
    super.dispose();
  }

  void _stateChangeCallback(FPullRefreshState state) {
    _scrollByState();
  }

  void _directionChangeCallback(FPullRefreshDirection direction) {
    setState(() {});
  }

  void _scrollByState() {
    final FPullRefreshState state = controller.state;
    switch (state) {
      case FPullRefreshState.refresh:
        final double targetOffset = currentHelper.getRefreshWidgetOffset();

        _animationController.animateTo(
          targetOffset,
          duration: currentHelper.getAnimationDuration(
            _kMinDuration,
            _kMaxDuration,
            currentOffset - targetOffset,
          ),
        );
        break;
      case FPullRefreshState.finish:
        _animationController.animateTo(
          0,
          duration: currentHelper.getAnimationDuration(
            _kMinDuration,
            _kMaxDuration,
            currentOffset,
          ),
        );
        break;
      default:
        break;
    }
  }

  bool _canPull(ScrollNotification notification) {
    return controller.state == FPullRefreshState.idle;
  }

  bool _handleNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          if (_canPull(notification)) {
            if (notification.metrics.extentBefore == 0.0) {
              _isDrag = true;
              controller._setDirection(FPullRefreshDirection.top);
              controller._setState(FPullRefreshState.pullRefresh);
            }
          }
          break;
        case ScrollDirection.reverse:
          break;
        case ScrollDirection.idle:
          _isDrag = false;
          if (controller.state == FPullRefreshState.releaseRefresh) {
            controller._setState(FPullRefreshState.refresh);
          } else if (controller.state == FPullRefreshState.pullRefresh) {
            controller._setState(FPullRefreshState.finish);
          }
          break;
      }
    } else if (notification is OverscrollNotification) {
      final double delta = -notification.overscroll / 3;
      _updateOffset(delta);
    } else if (notification is ScrollUpdateNotification) {
      final double delta = -notification.scrollDelta;
      if (delta > 0 && notification.metrics.extentBefore != 0.0) {
      } else {
        _updateOffset(delta);
      }
    }

    return false;
  }

  void _updateOffset(double delta) {
    if (!_isDrag) {
      return;
    }

    if (!currentHelper.isReady()) {
      return;
    }

    double targetOffset = currentOffset + delta;

    switch (controller._refreshDirection) {
      case FPullRefreshDirection.top:
        if (targetOffset < 0) {
          if (currentOffset == 0) {
            return;
          }
          targetOffset = 0;
        }

        break;
      case FPullRefreshDirection.bottom:
        // TODO: Handle this case.
        break;
      default:
        break;
    }

    final double refreshSize = currentHelper.getRefreshSize();
    if (targetOffset.abs() > refreshSize) {
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

  bool _handleGlowNotification(OverscrollIndicatorNotification notification) {
    if (notification.depth != 0 || !notification.leading) {
      return false;
    }
    if (_isDrag) {
      notification.disallowGlow();
      return true;
    }
    return false;
  }

  Widget _buildTop(BuildContext context) {
    Widget widget = _topHelper.newWidget(context, controller.state);
    final double targetOffset = _topHelper.getIndicatorOffset(currentOffset);

    widget = Transform.translate(
      offset: Offset(0.0, targetOffset),
      child: widget,
    );

    return widget;
  }

  Widget _wrapChildTransform(Widget widget) {
    return Transform.translate(
      offset: Offset(0.0, currentOffset),
      child: widget,
    );
  }

  Widget _wrapNotification(Widget widget) {
    return NotificationListener<ScrollNotification>(
      key: _notificationKey,
      onNotification: _handleNotification,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: _handleGlowNotification,
        child: widget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_kLogTag + 'build direction: ${controller._refreshDirection}');

    final Widget widgetNotification = _wrapNotification(widget.child);
    if (controller._refreshDirection == FPullRefreshDirection.none) {
      return widgetNotification;
    }

    final Widget widgetChild = controller.overlayMode
        ? widgetNotification
        : AnimatedBuilder(
            child: widgetNotification,
            animation: _animationController,
            builder: (context, child) {
              return _wrapChildTransform(child);
            },
          );

    final List<Widget> list = [];
    list.add(widgetChild);

    if (controller._refreshDirection == FPullRefreshDirection.top) {
      list.add(AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return _buildTop(context);
        },
      ));
    }

    return Stack(
      children: list,
    );
  }
}
