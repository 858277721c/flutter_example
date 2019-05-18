import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  final List<String> list = List.filled(20, "1", growable: true);

  @override
  void initState() {
    super.initState();
  }

  bool _onNotificationListenerCallback(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      print(
          '$runtimeType----- Start: ${notification.metrics} ${notification.metrics.axisDirection} ${notification.metrics.viewportDimension}');
    } else if (notification is ScrollUpdateNotification) {
      print(
          '$runtimeType----- Update: ${notification.metrics} ${notification.metrics.axisDirection} ${notification.scrollDelta}');
    } else if (notification is ScrollEndNotification) {
      print(
          '$runtimeType----- End: ${notification.metrics} ${notification.metrics.axisDirection} ${notification.metrics.viewportDimension}');
    } else if (notification is UserScrollNotification) {
      print(
          '$runtimeType----- User: ${notification.metrics} ${notification.metrics.axisDirection} ${notification.direction}');
    } else if (notification is OverscrollNotification) {
      print(
          '$runtimeType----- Over: ${notification.metrics} ${notification.metrics.axisDirection} ${notification.overscroll}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body = ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          child: ListTile(
            leading: Text('leading'),
            title: Text('title'),
            subtitle: Text('subtitle'),
            trailing: Text('trailing'),
            selected: index % 2 == 0,
          ),
        );
      },
    );

    body = NotificationListener<ScrollNotification>(
      child: body,
      onNotification: _onNotificationListenerCallback,
    );

    body = Container(
      width: 200,
      height: 200,
      child: body,
    );

    return Scaffold(
      appBar: FSimpleTitleBar(
        middle: Text(
          (ListViewPage).toString(),
        ),
      ),
      body: body,
    );
  }
}
