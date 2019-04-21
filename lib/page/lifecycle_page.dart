import 'package:flib_core/flib_core.dart';
import 'package:flib_lifecycle/flib_lifecycle.dart';
import 'package:flutter/material.dart';

class LifecyclePage extends StatefulWidget {
  @override
  _LifecyclePageState createState() => _LifecyclePageState();
}

class _LifecyclePageState extends FState<LifecyclePage> {
  @override
  void initState() {
    super.initState();
    getLifecycle().addObserver(_onLifecycleEvent);
  }

  void _onLifecycleEvent(FLifecycleEvent event, FLifecycle lifecycle) {
    print('LifecyclePage onEvent: ${event} ${lifecycle.getCurrentState()}');
  }

  @override
  Widget buildImpl(BuildContext context) {
    return FSafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.runtimeType.toString()),
      ),
      body: SingleChildScrollView(
        child: Container(),
      ),
    ));
  }
}
