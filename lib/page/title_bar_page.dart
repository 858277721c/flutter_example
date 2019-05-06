import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';

class TitleBarPage extends StatefulWidget {
  @override
  _TitleBarPageState createState() => _TitleBarPageState();
}

class _TitleBarPageState extends State<TitleBarPage> {
  @override
  Widget build(BuildContext context) {
    return FSafeArea(
      child: Scaffold(
        appBar: FSimpleTitleBar(
          middle: Text(
            widget.runtimeType.toString(),
          ),
          right: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FTitleBarItem(
                Text('aa'),
                onClick: () {},
              ),
              FTitleBarItem(
                Text('bb'),
                onClick: () {},
              ),
            ],
          ),
        ),
        body: Container(),
      ),
    );
  }
}
