import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/page/new_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int number = 0;

  @override
  void initState() {
    super.initState();
    print('MainPage initState');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('MainPage deactivate');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('MainPage didChangeDependencies');
  }

  @override
  void didUpdateWidget(MainPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('MainPage didUpdateWidget');
  }

  @override
  void dispose() {
    super.dispose();
    print('MainPage dispose');
  }

  @override
  Widget build(BuildContext context) {
    print('MainPage build');

    return FSafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.runtimeType.toString()),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  number++;
                  setState(() {});
                },
                child: Text(number.toString()),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed((NewPage).toString());
                },
                child: Text('new page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
