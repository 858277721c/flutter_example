import 'package:flutter/material.dart';
import 'package:my_flutter/pull_refresh/src/indicator/simple_text.dart';

import 'pull_refresh.dart';

class FPullRefreshView extends StatefulWidget {
  final FPullRefreshController controller;
  final FPullRefreshIndicator indicatorTop;
  final FPullRefreshIndicator indicatorBottom;

  FPullRefreshView({
    @required this.controller,
    FPullRefreshIndicator indicatorTop,
    FPullRefreshIndicator indicatorBottom,
  })  : assert(controller != null),
        this.indicatorTop = indicatorTop ?? FSimpleTextPullRefreshIndicator(),
        this.indicatorBottom =
            indicatorBottom ?? FSimpleTextPullRefreshIndicator();

  @override
  _FPullRefreshViewState createState() => _FPullRefreshViewState();
}

class _FPullRefreshViewState extends State<FPullRefreshView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
