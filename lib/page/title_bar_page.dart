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
          elevation: 20,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage('images/bg_blue.png'),
            ),
          ),
          middle: Text(
            widget.runtimeType.toString(),
          ),
          right: <Widget>[
            FTitleBarItem(
              Text('收藏'),
              onClick: () {},
            ),
            FTitleBarItem(
              Text('关注'),
              onClick: () {},
            ),
          ],
        ),
        body: Container(),
      ),
    );
  }
}
