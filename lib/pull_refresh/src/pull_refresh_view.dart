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

  double _offset = 0.0;
  DirectionHelper _topHelper;
  DirectionHelper _helper;

  Timer _refreshResultTimer;

  @override
  void initState() {
    super.initState();
    _topHelper = TopDirectionHelper(widget.indicatorTop);

    _animationController = AnimationController(
      vsync: this,
      lowerBound: -1000,
      upperBound: 1000,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
    final double targetOffset = _offset += delta;

    print('$runtimeType----- _offset: $targetOffset');

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

    _offset = targetOffset;
    _animationController.value = targetOffset;
  }

  Widget _buildTop(BuildContext context) {
    Widget widget = _topHelper.newWidget(context, _state);
    final double offset = _topHelper.getIndicatorOffset(_offset);

    widget = Transform.translate(
      offset: Offset(0.0, offset),
      child: widget,
    );

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    final Widget widgetTop = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return _buildTop(context);
      },
    );

    final List<Widget> list = [];
    list.add(widget.child);
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

  bool _canPull(ScrollNotification notification) {
    return _state == FPullRefreshState.idle;
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
          }
          break;
      }
    } else if (notification is ScrollUpdateNotification) {
    } else if (notification is OverscrollNotification) {
      if (_state == FPullRefreshState.pullRefresh ||
          _state == FPullRefreshState.releaseRefresh) {
        _updateOffset(notification.dragDetails.primaryDelta / 3);
      }
    } else if (notification is ScrollEndNotification) {
      _offset = 0;
    }

    return false;
  }
}
