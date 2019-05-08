import 'package:flutter/material.dart';
import 'package:my_flutter/pull_refresh/src/pull_refresh.dart';

class FSimpleTextPullRefreshIndicator implements FPullRefreshIndicator {
  @override
  Widget build(FPullRefreshController controller) {
    return _SimpleTextIndicator(controller);
  }
}

class _SimpleTextIndicator extends StatefulWidget {
  final FPullRefreshController controller;

  _SimpleTextIndicator(this.controller);

  @override
  _SimpleTextIndicatorState createState() => _SimpleTextIndicatorState();
}

class _SimpleTextIndicatorState extends State<_SimpleTextIndicator> {
  @override
  void initState() {
    super.initState();
    widget.controller.addStateChangeCallback(_onStateChanged);
  }

  @override
  void didUpdateWidget(_SimpleTextIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeStateChangeCallback(_onStateChanged);
      widget.controller.addStateChangeCallback(_onStateChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeStateChangeCallback(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged(FPullRefreshState state) {}

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
