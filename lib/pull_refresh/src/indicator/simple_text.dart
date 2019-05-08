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

  String _getStateText() {
    switch (widget.controller.state) {
      case FPullRefreshState.idle:
        return '';
      case FPullRefreshState.pullRefresh:
        return '下载刷新';
      case FPullRefreshState.releaseRefresh:
        break;
      case FPullRefreshState.refresh:
        return '刷新中';
      case FPullRefreshState.refreshResult:
        final dynamic result = widget.controller.refreshResult;
        if (result is bool) {
          if (result) {
            return '刷新成功';
          } else {
            return '刷新失败';
          }
        }
        return '刷新完成';
      case FPullRefreshState.refreshFinish:
        return '下载刷新';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(_getStateText()),
    );
  }
}
