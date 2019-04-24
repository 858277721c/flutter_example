import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';

class EventBusPage extends StatefulWidget {
  @override
  _EventBusPageState createState() => _EventBusPageState();
}

class _ENumberChange {
  final int number;

  _ENumberChange(this.number);
}

class _EventBusPageState extends State<EventBusPage> {
  int _number = 0;

  @override
  Widget build(BuildContext context) {
    return FSafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.runtimeType.toString()),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FButton.raised(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              onPressed: () {
                _number++;
                FEventBus.getDefault().post(_ENumberChange(_number));
              },
              child: Text(
                _number.toString(),
              ),
            ),
            _TestView(),
          ],
        ),
      ),
    ));
  }
}

class _TestView extends StatefulWidget {
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends FState<_TestView> {
  int _number = 0;

  @override
  void initState() {
    super.initState();
    FEventBus.getDefault().addObserver<_ENumberChange>((event) {
      _number = event.number;
      reBuild();
    }, this);
  }

  @override
  Widget buildImpl(BuildContext context) {
    return Container(
      child: Text(_number.toString()),
    );
  }
}
