import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';

import 'new_page.dart';

class LifecyclePage extends StatefulWidget {
  @override
  _LifecyclePageState createState() => _LifecyclePageState();
}

class _LifecyclePageState extends FState<LifecyclePage> {
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
    return FSafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.runtimeType.toString()),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: GestureDetector(
            child: Text('click'),
            onTap: () {
              Navigator.of(context).pushNamed((NewPage).toString());
            },
          ),
        ),
      ),
    ));
  }
}
