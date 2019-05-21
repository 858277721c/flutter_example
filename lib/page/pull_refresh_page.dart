import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/pull_refresh/flib_pull_refresh.dart';

class PullRefreshPage extends StatefulWidget {
  @override
  _PullRefreshPageState createState() => _PullRefreshPageState();
}

class _PullRefreshPageState extends State<PullRefreshPage> {
  final List<String> list = List.filled(20, "1", growable: true);

  final FPullRefreshController pullRefreshController =
      FPullRefreshController.create();

  @override
  void initState() {
    super.initState();
    pullRefreshController.overlayMode = false;
    pullRefreshController.setRefreshCallback((direction) {
      Future.delayed(Duration(seconds: 1)).then((value) {
        pullRefreshController.stopRefresh();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body = ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text('leading'),
          title: Text('title'),
          subtitle: Text('subtitle'),
          trailing: Text(index.toString()),
          selected: index % 2 == 0,
        );
      },
    );

    body = pullRefreshController.newRefreshWidget(child: body);

    body = Container(child: body);

    return Scaffold(
      appBar: FSimpleTitleBar(
        middle: Text(
          (PullRefreshPage).toString(),
        ),
      ),
      body: body,
    );
  }
}
