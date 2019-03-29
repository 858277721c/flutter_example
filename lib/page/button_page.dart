import 'package:flib_core/flib_core.dart';
import 'package:flib_core/src/button.dart';
import 'package:flutter/material.dart';

class ButtonPage extends StatefulWidget {
  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  @override
  Widget build(BuildContext context) {
    return FSafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.runtimeType.toString()),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                /// RaisedButton
                RaisedButton(
                  onPressed: null,
                  child: Text('RaisedButton'),
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text('RaisedButton'),
                ),

                /// FlatButton
                FlatButton(
                  onPressed: null,
                  child: Text('FlatButton'),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text('FlatButton'),
                ),

                /// OutlineButton
                OutlineButton(
                  onPressed: null,
                  child: Text('OutlineButton'),
                ),
                OutlineButton(
                  onPressed: () {},
                  child: Text('OutlineButton'),
                ),

                FDivider(size: 1),

                /// RaisedButton
                FButton.raised(
                  onPressed: null,
                  child: Text('RaisedButton'),
                ),
                FButton.raised(
                  onPressed: () {},
                  child: Text('RaisedButton'),
                ),

                /// FlatButton
                FButton.flat(
                  onPressed: null,
                  child: Text('FlatButton'),
                ),
                FButton.flat(
                  onPressed: () {},
                  child: Text('FlatButton'),
                ),

                /// OutlineButton
                FButton.outline(
                  onPressed: null,
                  child: Text('OutlineButton'),
                ),
                FButton.outline(
                  onPressed: () {},
                  child: Text('OutlineButton'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
