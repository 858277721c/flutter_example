import 'package:flutter/material.dart';

import 'pull_refresh.dart';

class FPullRefreshView extends StatefulWidget {
  final FPullRefreshController controller;
  final FPullRefreshIndicator indicatorTop;
  final FPullRefreshIndicator indicatorBottom;

  FPullRefreshView({
    FPullRefreshController controller,
    this.indicatorTop,
    this.indicatorBottom,
  }) : this.controller = controller ?? FSimplePullRefreshController();

  @override
  _FPullRefreshViewState createState() => _FPullRefreshViewState();
}

class _FPullRefreshViewState extends State<FPullRefreshView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
