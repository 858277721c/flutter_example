import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_flutter/pull_refresh/src/indicator/simple_text.dart';

import 'direction_helper.dart';
import 'pull_refresh.dart';

class FPullRefreshView extends StatefulWidget {
  final Widget child;

  final FPullRefreshIndicator indicatorTop;

  FPullRefreshView({
    @required this.child,
    FPullRefreshIndicator indicatorTop,
  }) : this.indicatorTop = indicatorTop ?? FSimpleTextPullRefreshIndicator();

  @override
  _FPullRefreshViewState createState() => _FPullRefreshViewState();
}

class _FPullRefreshViewState extends State<FPullRefreshView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  FPullRefreshState _state = FPullRefreshState.idle;
  FPullRefreshDirection _refreshDirection = FPullRefreshDirection.none;

  DirectionHelper _topHelper;
  DirectionHelper _helper;

  Timer _refreshResultTimer;

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

  double get offset {
    return _animationController.value;
  }

  void _setDirection(FPullRefreshDirection direction) {
    assert(direction != null);
    assert(_state == FPullRefreshState.idle);

    if (_refreshDirection != direction) {
      _refreshDirection = direction;

      print('$runtimeType-----  _setDirection: $direction');

      switch (direction) {
        case FPullRefreshDirection.top:
          _helper = _topHelper;
          break;
        case FPullRefreshDirection.bottom:
          _helper = null;
          break;
        default:
          _helper = null;
          break;
      }
    }
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

    if (_refreshResultTimer != null) {
      _refreshResultTimer.cancel();
      _refreshResultTimer = null;
    }
    if (state == FPullRefreshState.refreshResult) {
      _refreshResultTimer = Timer(Duration(milliseconds: 600), () {
        _stopRefresh();
      });
    }
  }

  void _stopRefresh() {}

  void _updateOffset(double delta) {
    final double targetOffset = offset + delta;

    print('$runtimeType----- targetOffset: $targetOffset');

    final double refreshSize = _helper.getRefreshSize();
    if (targetOffset.abs() >= refreshSize) {
      if (_state == FPullRefreshState.pullRefresh) {
        _setState(FPullRefreshState.releaseRefresh);
      }
    } else {
      if (_state == FPullRefreshState.releaseRefresh) {
        _setState(FPullRefreshState.pullRefresh);
      }
    }

    _animationController.value = targetOffset;
  }

  bool _canPull(ScrollNotification notification) {
    return _state == FPullRefreshState.idle;
  }

  bool _isDrag() {
    return _state == FPullRefreshState.pullRefresh ||
        _state == FPullRefreshState.releaseRefresh;
  }

  bool _handleNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
    } else if (notification is UserScrollNotification) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          if (_canPull(notification)) {
            if (notification.metrics.extentBefore == 0.0 &&
                _topHelper.getIndicatorSize() != null) {
              _setDirection(FPullRefreshDirection.top);
              _setState(FPullRefreshState.pullRefresh);
            }
          }
          break;
        case ScrollDirection.reverse:
          break;
        case ScrollDirection.idle:
          if (_state == FPullRefreshState.releaseRefresh) {
            _setState(FPullRefreshState.refresh);
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
    switch (_state) {
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
        final double targetOffset = _helper.getRefreshOffset();

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
    Widget widget = _topHelper.newWidget(context, _state);
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
