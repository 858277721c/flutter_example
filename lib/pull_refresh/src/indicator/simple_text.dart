import 'package:flutter/material.dart';
import 'package:my_flutter/pull_refresh/src/pull_refresh.dart';

class FSimpleTextPullRefreshIndicator extends FPullRefreshIndicator {
  String _getStateText(FPullRefreshState state) {
    switch (state) {
      case FPullRefreshState.idle:
        return '下拉刷新';
      case FPullRefreshState.pullStart:
        return '下拉刷新';
      case FPullRefreshState.pullReady:
        return '松开刷新';
      case FPullRefreshState.refresh:
        return '刷新中';
      case FPullRefreshState.refreshResult:
        return '刷新完成';
      case FPullRefreshState.finish:
        return '下拉刷新';
    }
    return '';
  }

  @override
  Widget build(BuildIndicatorInfo info) {
    return Container(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: 50,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(_getStateText(info.state)),
        ],
      ),
    );
  }
}
