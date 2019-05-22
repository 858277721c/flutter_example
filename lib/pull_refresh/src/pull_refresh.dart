import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_flutter/pull_refresh/src/indicator/simple_indicator.dart';

import 'direction_helper.dart';

typedef FPullRefreshCallback = void Function(FPullRefreshDirection direction);

typedef FPullRefreshStateChangeCallback = void Function(
    FPullRefreshState state);

typedef FPullRefreshDirectionChangeCallback = void Function(
    FPullRefreshDirection direction);

enum FPullRefreshState {
  /// 空闲状态
  idle,

  /// 拖动状态，还未达到可以刷新的条件
  pullStart,

  /// 拖动状态，已经达到可以刷新的条件
  pullReady,

  /// 刷新中
  refresh,

  /// 展示刷新结果
  refreshResult,

  /// 结束状态，在动画结束后，回到[FPullRefreshState.idle]状态
  finish,
}

enum FPullRefreshDirection {
  none,
  start,
  end,
}

abstract class FPullRefreshIndicator {
  Widget build(BuildIndicatorInfo info);

  double getReadySize() {
    return null;
  }

  double getRefreshSize() {
    return null;
  }
}

class BuildIndicatorInfo {
  final BuildContext context;
  final Axis axis;
  final FPullRefreshState state;
  final FPullRefreshDirection direction;

  final double offset;
  final double readySize;
  final double refreshSize;

  BuildIndicatorInfo({
    this.context,
    this.axis,
    this.state,
    this.direction,
    this.offset,
    double readySize,
    double refreshSize,
  })  : assert(context != null),
        assert(axis != null),
        assert(state != null),
        assert(direction != null),
        assert(offset != null),
        this.readySize = readySize ?? 0,
        this.refreshSize = refreshSize ?? 0;

  double readyPercent() {
    final double percent = offset.abs() / readySize;
    return percent.clamp(0.0, 1.0);
  }
}

const Duration _kMaxDuration = const Duration(milliseconds: 150);
const Duration _kMinDuration = const Duration(milliseconds: 50);
const String _kLogTag = 'FPullRefresh----- ';

class FPullRefreshConfig {
  static final FPullRefreshConfig singleton = FPullRefreshConfig._();

  FPullRefreshConfig._() {
    indicatorStart = FSimpleCircularRefreshIndicator();
    indicatorEnd = FSimpleCircularRefreshIndicator();
  }

  FPullRefreshIndicator _indicatorStart;
  FPullRefreshIndicator _indicatorEnd;

  FPullRefreshIndicator get indicatorStart => _indicatorStart;

  set indicatorStart(FPullRefreshIndicator value) {
    assert(value != null);
    _indicatorStart = value;
  }

  FPullRefreshIndicator get indicatorEnd => _indicatorEnd;

  set indicatorEnd(FPullRefreshIndicator value) {
    assert(value != null);
    _indicatorEnd = value;
  }
}

//---------- Controller ----------

abstract class FPullRefreshController {
  factory FPullRefreshController.create({
    Axis axis,
    FPullRefreshIndicator indicatorStart,
    FPullRefreshIndicator indicatorEnd,
  }) {
    return _SimplePullRefreshController(axis: axis);
  }

  FPullRefreshState get state;

  dynamic get refreshResult;

  FPullRefreshDirection get refreshDirection;

  bool get overlayMode;

  void setOverlayMode(bool overlay);

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
  void startRefresh({FPullRefreshDirection direction});

  /// 停止刷新
  void stopRefresh({dynamic result});

  /// 创建一个刷新Widget
  Widget newRefreshWidget({
    @required Widget child,
  });
}

class _BasePullRefreshController implements FPullRefreshController {
  final Axis _axis;
  final FPullRefreshIndicator _indicatorStart;
  final FPullRefreshIndicator _indicatorEnd;

  FPullRefreshState _state = FPullRefreshState.idle;
  dynamic _refreshResult;
  FPullRefreshDirection _refreshDirection = FPullRefreshDirection.none;
  bool _overlayMode = false;

  Timer _stopRefreshTimer;

  FPullRefreshCallback _refreshCallback;
  final List<FPullRefreshStateChangeCallback> _listStateChangeCallback = [];
  final List<FPullRefreshDirectionChangeCallback> _listDirectionChangeCallback =
      [];

  DirectionHelper _directionHelper;

  _BasePullRefreshController({
    Axis axis,
    FPullRefreshIndicator indicatorStart,
    FPullRefreshIndicator indicatorEnd,
  })  : this._axis = axis ?? Axis.vertical,
        this._indicatorStart =
            indicatorStart ?? FPullRefreshConfig.singleton.indicatorStart,
        this._indicatorEnd =
            indicatorEnd ?? FPullRefreshConfig.singleton.indicatorEnd;

  @override
  FPullRefreshState get state => _state;

  @override
  dynamic get refreshResult => _refreshResult;

  @override
  FPullRefreshDirection get refreshDirection => _refreshDirection;

  @override
  bool get overlayMode => _overlayMode;

  @override
  void setOverlayMode(bool overlay) {
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
  void startRefresh({FPullRefreshDirection direction}) {
    direction ??= FPullRefreshDirection.start;
    assert(direction != FPullRefreshDirection.none);
    if (_state == FPullRefreshState.idle) {
      _setDirection(direction);
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
  }) {
    return _PullRefreshView(
      controller: this,
      child: child,
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

      switch (direction) {
        case FPullRefreshDirection.start:
          _directionHelper = TopDirectionHelper(_indicatorStart);
          break;
        case FPullRefreshDirection.end:
          _directionHelper = BottomDirectionHelper(_indicatorEnd);
          break;
        case FPullRefreshDirection.none:
          _directionHelper = null;
          break;
      }

      _notifyDirectionChangeCallback(direction);
    }
  }
}

class _SimplePullRefreshController extends _BasePullRefreshController {
  bool _isDrag = false;

  _SimplePullRefreshController({
    Axis axis,
    FPullRefreshIndicator indicatorStart,
    FPullRefreshIndicator indicatorEnd,
  }) : super(
          axis: axis,
          indicatorStart: indicatorStart,
          indicatorEnd: indicatorEnd,
        );

  void _dragStart(FPullRefreshDirection direction) {
    assert(direction != FPullRefreshDirection.none);
    _isDrag = true;
    _setDirection(direction);
    _setState(FPullRefreshState.pullStart);
  }

  void _dragFinish() {
    assert(_isDrag = true);
    _isDrag = false;
    if (state == FPullRefreshState.pullReady) {
      _setState(FPullRefreshState.refresh);
    } else if (state == FPullRefreshState.pullStart) {
      _setState(FPullRefreshState.finish);
    }
  }
}

//---------- View ----------

class _PullRefreshView extends StatefulWidget {
  final FPullRefreshController controller;
  final Widget child;

  _PullRefreshView({
    @required this.controller,
    @required this.child,
  })  : assert(controller != null),
        assert(child != null);

  @override
  _PullRefreshViewState createState() => _PullRefreshViewState();
}

class _PullRefreshViewState extends State<_PullRefreshView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final GlobalKey _notificationKey = GlobalKey();

  _SimplePullRefreshController get controller {
    return widget.controller;
  }

  double get currentOffset {
    return _animationController.value;
  }

  DirectionHelper get currentHelper {
    return controller._directionHelper;
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

    _registerController(controller);
  }

  void _registerController(FPullRefreshController controller) {
    controller.addStateChangeCallback(_stateChangeCallback);
    controller.addDirectionChangeCallback(_directionChangeCallback);
  }

  void _unregisterController(FPullRefreshController controller) {
    controller.removeStateChangeCallback(_stateChangeCallback);
    controller.removeDirectionChangeCallback(_directionChangeCallback);
  }

  @override
  void didUpdateWidget(_PullRefreshView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _unregisterController(oldWidget.controller);
      _registerController(controller);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _unregisterController(controller);
    super.dispose();
  }

  void _stateChangeCallback(FPullRefreshState state) {
    _updateIndicator();
    _scrollByState();
  }

  void _directionChangeCallback(FPullRefreshDirection direction) {
    setState(() {});
  }

  void _updateIndicator() {
    if (controller.refreshDirection != FPullRefreshDirection.none) {
      _animationController.value = _animationController.value;
    }
  }

  void _scrollByState() {
    final FPullRefreshState state = controller.state;
    switch (state) {
      case FPullRefreshState.refresh:
        final double targetOffset =
            currentHelper.getRefreshWidgetRefreshOffset();

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
              controller._dragStart(FPullRefreshDirection.start);
            }
          }
          break;
        case ScrollDirection.reverse:
          if (_canPull(notification)) {
            if (notification.metrics.extentAfter == 0.0) {
              controller._dragStart(FPullRefreshDirection.end);
            }
          }
          break;
        case ScrollDirection.idle:
          controller._dragFinish();
          break;
      }
    } else if (notification is OverscrollNotification) {
      final double delta = -notification.overscroll;
      _processDrag(delta / 3);
    } else if (notification is ScrollUpdateNotification) {
      final double delta = -notification.scrollDelta;

      final FPullRefreshDirection direction = controller.refreshDirection;
      if (direction == FPullRefreshDirection.start) {
        if (delta > 0 && notification.metrics.extentBefore != 0.0) {
        } else {
          _processDrag(delta);
        }
      } else if (direction == FPullRefreshDirection.end) {
        if (delta < 0 && notification.metrics.extentAfter != 0.0) {
        } else {
          _processDrag(delta);
        }
      }
    }

    return false;
  }

  void _processDrag(double delta) {
    if (!controller._isDrag) {
      return;
    }

    if (!currentHelper.isReady()) {
      return;
    }

    final double targetOffset =
        currentHelper.computeRefreshWidgetOffset(currentOffset, delta);

    if (targetOffset == 0 && currentOffset == 0) {
      return;
    }

    final double readySize = currentHelper.getIndicatorReadySize();
    if (targetOffset.abs() > readySize) {
      if (controller.state == FPullRefreshState.pullStart) {
        controller._setState(FPullRefreshState.pullReady);
      }
    } else {
      if (controller.state == FPullRefreshState.pullReady) {
        controller._setState(FPullRefreshState.pullStart);
      }
    }

    _animationController.value = targetOffset;
  }

  bool _handleGlowNotification(OverscrollIndicatorNotification notification) {
    if (notification.depth != 0) {
      return false;
    }
    if (controller._isDrag) {
      notification.disallowGlow();
      return true;
    }
    return false;
  }

  Widget _buildIndicator(BuildContext context) {
    final Widget widget = currentHelper.newWidget(
      BuildIndicatorInfo(
        context: context,
        axis: controller._axis,
        state: controller.state,
        direction: controller.refreshDirection,
        offset: currentOffset,
        readySize: currentHelper.getIndicatorReadySize(),
        refreshSize: currentHelper.getIndicatorRefreshSize(),
      ),
    );

    return _wrapIndicatorPosition(widget);
  }

  Widget _wrapIndicatorPosition(Widget widget) {
    Alignment alignment;

    final FPullRefreshDirection direction = controller.refreshDirection;
    switch (direction) {
      case FPullRefreshDirection.start:
        alignment = Alignment.topCenter;
        break;
      case FPullRefreshDirection.end:
        alignment = Alignment.bottomCenter;
        break;
      default:
        throw Exception('Illegal direction: $direction');
    }

    final double targetOffset = currentHelper.getIndicatorOffset(currentOffset);
    return Align(
      alignment: alignment,
      child: Transform.translate(
        offset: Offset(0.0, targetOffset),
        child: widget,
      ),
    );
  }

  Widget _wrapChildPosition(Widget widget) {
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
    print(_kLogTag + 'build direction: ${controller.refreshDirection}');

    final Widget widgetNotification = _wrapNotification(widget.child);
    if (controller.refreshDirection == FPullRefreshDirection.none) {
      return widgetNotification;
    }

    final Widget widgetChild = controller.overlayMode
        ? widgetNotification
        : AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return _wrapChildPosition(widgetNotification);
            },
          );

    final List<Widget> list = [];

    list.add(
      widgetChild,
    );

    list.add(
      AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return _buildIndicator(context);
        },
      ),
    );

    return Stack(
      children: list,
    );
  }
}
