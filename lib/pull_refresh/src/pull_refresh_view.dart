import 'package:flutter/material.dart';
import 'package:my_flutter/pull_refresh/src/indicator/simple_text.dart';

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

  @override
  void initState() {
    super.initState();
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

  Widget _wrapTransform(Widget widget) {
    return Transform.translate(
      offset: Offset(0, 0),
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = [];
    Widget widgetTop = widget.indicatorTop.build(widget.controller);

    list.add(widget.child);

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
    return notification.metrics.extentBefore == 0.0 &&
        _state == FPullRefreshState.idle;
  }

  bool _handleNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      if (_canPull(notification)) {}

      if (notification.metrics.axisDirection == AxisDirection.down) {}
    } else if (notification is ScrollUpdateNotification) {}

    return false;
  }
}
