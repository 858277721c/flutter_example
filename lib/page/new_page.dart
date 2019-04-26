import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return FSafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.runtimeType.toString()),
        ),
        body: Container(),
      ),
    );
  }
}
