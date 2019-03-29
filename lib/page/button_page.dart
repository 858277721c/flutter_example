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
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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

                /// FRaisedButton
                FRaisedButton(
                  onPressed: null,
                  child: Text('FRaisedButton'),
                ),
                FRaisedButton(
                  onPressed: () {},
                  child: Text('FRaisedButton'),
                ),

                /// FRaisedButton
                FFlatButton(
                  onPressed: null,
                  child: Text('FFlatButton'),
                ),
                FFlatButton(
                  onPressed: () {},
                  child: Text('FFlatButton'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
