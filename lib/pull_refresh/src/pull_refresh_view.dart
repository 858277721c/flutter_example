import 'package:flutter/material.dart';

import 'pull_refresh.dart';

class FPullRefreshView extends StatefulWidget {
  final FPullRefresh pullRefresh;

  FPullRefreshView({@required this.pullRefresh}) : assert(pullRefresh != null);

  @override
  _FPullRefreshViewState createState() => _FPullRefreshViewState();
}

class _FPullRefreshViewState extends State<FPullRefreshView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
