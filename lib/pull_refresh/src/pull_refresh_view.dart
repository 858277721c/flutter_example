import 'package:flutter/material.dart';
import 'package:my_flutter/pull_refresh/src/indicator/simple_text.dart';

import 'direction_helper.dart';
import 'pull_refresh.dart';

class FPullRefreshView extends StatefulWidget {
  final FPullRefreshController controller;
  final Widget child;

  final FPullRefreshIndicator indicatorTop;
  final FPullRefreshIndicator indicatorBottom;

  FPullRefreshView({
    @required this.controller,
    @required this.child,
    FPullRefreshIndicator indicatorTop,
    FPullRefreshIndicator indicatorBottom,
  })  : assert(controller != null),
        this.indicatorTop = indicatorTop ?? FSimpleTextPullRefreshIndicator(),
        this.indicatorBottom =
            indicatorBottom ?? FSimpleTextPullRefreshIndicator();

  @override
  _FPullRefreshViewState createState() => _FPullRefreshViewState();
}

class _FPullRefreshViewState extends State<FPullRefreshView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  FPullRefreshState _state = FPullRefreshState.idle;

  bool _isDrag = false;
  double _offset = 0.0;

  DirectionHelper topHelper;
  DirectionHelper bottomHelper;

  @override
  void initState() {
    super.initState();
    topHelper = TopDirectionHelper(
      widget.indicatorTop,
      widget.controller,
    );

    bottomHelper = BottomDirectionHelper(
      widget.indicatorBottom,
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

  void _updateIfNeed() {
    final FPullRefreshState newState = widget.controller.state;
    if (_state != newState) {
      _state = newState;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetTop = topHelper.newWidget();
    widgetTop = topHelper.wrapPosition(widgetTop, _offset);

    Widget widgetBottom = bottomHelper.newWidget();
    widgetBottom = bottomHelper.wrapPosition(widgetBottom, _offset);

    final List<Widget> list = [];
    list.add(widget.child);
    list.add(widgetTop);
    list.add(widgetBottom);

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
              _isDrag = true;
            }
            break;
          case AxisDirection.up:
            // TODO: Handle this case.
            break;
          default:
            break;
        }
      }
    } else if (notification is ScrollUpdateNotification) {
      _offset -= notification.dragDetails.primaryDelta;
    }

    return false;
  }
}
