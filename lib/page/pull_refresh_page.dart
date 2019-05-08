import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';

class PullRefreshPage extends StatefulWidget {
  @override
  _PullRefreshPageState createState() => _PullRefreshPageState();
}

class _PullRefreshPageState extends State<PullRefreshPage> {
  final List<String> list = List.filled(20, "1", growable: true);

  @override
  void initState() {
    super.initState();
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
          trailing: Text('trailing'),
          selected: index % 2 == 0,
        );
      },
    );

    body = RefreshIndicator(
      child: body,
      onRefresh: () {
        return Future.delayed(Duration(seconds: 2));
      },
    );

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
