import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';

class InkPage extends StatefulWidget {
  @override
  _InkPageState createState() => _InkPageState();
}

class _InkPageState extends State<InkPage> {
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
              Material(
                color: Colors.red,
                child: InkWell(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: Text('test'),
                  ),
                  onTap: () {
                    print('InkPage onTap');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
