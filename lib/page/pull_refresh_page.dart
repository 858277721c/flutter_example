import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/pull_refresh/flib_pull_refresh.dart';

class PullRefreshPage extends StatefulWidget {
  @override
  _PullRefreshPageState createState() => _PullRefreshPageState();
}

class _PullRefreshPageState extends State<PullRefreshPage> {
  final List<String> list = List.filled(50, "1", growable: true);

  final FPullRefreshController verticalRefreshController =
      FPullRefreshController.create();

  final FPullRefreshController horizontalRefreshController =
      FPullRefreshController.create(axis: Axis.horizontal);

  @override
  void initState() {
    super.initState();
    verticalRefreshController.setRefreshCallback((direction) {
      Future.delayed(Duration(seconds: 2)).then((value) {
        verticalRefreshController.stopRefresh();
      });
    });

    horizontalRefreshController.setRefreshCallback((direction) {
      Future.delayed(Duration(seconds: 2)).then((value) {
        horizontalRefreshController.stopRefresh();
      });
    });
  }

  Widget buildTop() {
    Widget widget = ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            children: <Widget>[
              Text(index.toString()),
              Container(
                color: Colors.black,
                height: 1,
              )
            ],
          ),
        );
      },
    );

    return verticalRefreshController.newRefreshWidget(child: widget);
  }

  Widget buildBottom() {
    Widget widget = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Container(
          child: Row(
            children: <Widget>[
              Text(index.toString()),
              Container(
                color: Colors.black,
                width: 1,
              )
            ],
          ),
        );
      },
    );

    return horizontalRefreshController.newRefreshWidget(child: widget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FSimpleTitleBar(
        middle: Text(
          (PullRefreshPage).toString(),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(child: buildTop()),
            SizedBox(height: 50),
            Expanded(child: buildBottom()),
          ],
        ),
      ),
    );
  }
}
