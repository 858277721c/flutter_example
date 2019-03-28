import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';

class SystemBarPage extends StatefulWidget {
  @override
  _SystemBarPageState createState() => _SystemBarPageState();
}

class _SystemBarPageState extends State<SystemBarPage> {
  @override
  Widget build(BuildContext context) {
    return FSystemUiOverlay(
      style: FSystemUiOverlayStyle(topColor: Colors.green),
      child: FSafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.runtimeType.toString()),
          ),
          body: Container(),
        ),
      ),
    );
  }
}
