import 'package:flutter/material.dart';
import 'package:my_flutter/pull_refresh/src/indicator/simple_text.dart';

import 'direction_helper.dart';
import 'pull_refresh.dart';

class FPullRefreshView extends StatefulWidget {
  final FPullRefreshController controller;
  final Widget child;

  final FPullRefreshIndicator indicatorTop;

  FPullRefreshView({
    @required this.controller,
    @required this.child,
    FPullRefreshIndicator indicatorTop,
  })  : assert(controller != null),
        this.indicatorTop = indicatorTop ?? FSimpleTextPullRefreshIndicator();

  @override
  _FPullRefreshViewState createState() => _FPullRefreshViewState();
}

class _FPullRefreshViewState extends State<FPullRefreshView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  FPullRefreshState _state = FPullRefreshState.idle;
  double _offset = 0.0;

  DirectionHelper topHelper;

  @override
  void initState() {
    super.initState();
    topHelper = TopDirectionHelper(
      widget.indicatorTop,
      widget.controller,
    );

    widget.controller.addStateChangeCallback(_onStateChanged);
    _animationController = AnimationController(vsync: this);
  }

  @override
  void didUpdateWidget(FPullRefreshView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeStateChangeCallback(_onStateChanged);
      widget.controller.addStateChangeCallback(_onStateChanged);
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    widget.controller.removeStateChangeCallback(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged(FPullRefreshState state) {
    _updateIfNeed();
  }

  void _updateIfNeed() {}

  void _updateOffset(double delta) {
    _offset += delta;
    _animationController.value = _offset;
  }

  @override
  Widget build(BuildContext context) {
    final Widget widgetTop = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        Widget widget = topHelper.newWidget();
        final double top = topHelper.getIndicatorOffset(_offset);

        print('top offset: $top');

        widget = Positioned(
          child: widget,
          top: top,
        );
        return widget;
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
      if (_canPull(notification)) {
        final AxisDirection axisDirection = notification.metrics.axisDirection;
        switch (axisDirection) {
          case AxisDirection.down:
            if (notification.metrics.extentBefore == 0.0) {
              _state = FPullRefreshState.pullRefresh;
            }
            break;
          case AxisDirection.up:
            break;
          default:
            break;
        }
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
