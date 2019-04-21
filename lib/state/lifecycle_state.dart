import 'package:flib_lifecycle/flib_lifecycle.dart';
import 'package:flutter/material.dart';

abstract class LifecycleState<T extends StatefulWidget> extends State<T> {
  final SimpleLifecycle simpleLifecycle = SimpleLifecycle();

  bool _started;

  @override
  void initState() {
    super.initState();
    simpleLifecycle.handleLifecycleEvent(FLifecycleEvent.onCreate);
  }

  @override
  void dispose() {
    super.dispose();
    simpleLifecycle.handleLifecycleEvent(FLifecycleEvent.onDestroy);
  }

  @override
  void deactivate() {
    super.deactivate();
    _started = !_started;
    _notifyStartOrStop();
  }

  @override
  Widget build(BuildContext context) {
    if (_started == null) {
      _started = true;
      _notifyStartOrStop();
    }
    return buildImpl(context);
  }

  Widget buildImpl(BuildContext context);

  void _notifyStartOrStop() {
    if (_started) {
      onStart();
      simpleLifecycle.handleLifecycleEvent(FLifecycleEvent.onStart);
    } else {
      onStop();
      simpleLifecycle.handleLifecycleEvent(FLifecycleEvent.onStop);
    }
  }

  void onStart() {}

  void onStop() {}
}
