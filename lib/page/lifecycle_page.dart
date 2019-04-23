import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';

class LifecyclePage extends StatefulWidget {
  @override
  _LifecyclePageState createState() => _LifecyclePageState();
}

class _LifecyclePageState extends FState<LifecyclePage> {
  final FValueNotifier<int> number = FValueNotifier(0);
  bool _addTestView = false;

  @override
  void initState() {
    super.initState();
    getLifecycle().addObserver(_lifecycleObserver);
  }

  void _lifecycleObserver(FLifecycleEvent event, FLifecycle lifecycle) {
    print('LifecyclePage onEvent: ${event}');
  }

  @override
  Widget buildImpl(BuildContext context) {
    final List<Widget> list = [];
    list.add(FButton.raised(
      onPressed: () {
        _addTestView = !_addTestView;
        setState(() {});
      },
      child: Text('toggle view'),
    ));

    list.add(FButton.raised(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      onPressed: () {
        number.value = ++number.value;
        setState(() {});
      },
      child: Text(number.value.toString()),
    ));

    if (_addTestView) {
      list.add(_TestStateView());
    }

    return FSafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.runtimeType.toString()),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: list,
          ),
        ),
      ),
    ));
  }
}

class _TestStateView extends StatefulWidget {
  @override
  _TestStateViewState createState() => _TestStateViewState();
}

class _TestStateViewState
    extends FAccessTargetState<_TestStateView, _LifecyclePageState> {
  @override
  void onTargetState(_LifecyclePageState state) {
    state.number.addObserver((value) {
      setState(() {});
    }, this);
  }

  @override
  Widget buildImpl(BuildContext context) {
    return Container(
      child: Text('TestStateView: ${targetState.number.value}'),
    );
  }
}
