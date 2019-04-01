import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';

class StepperPage extends StatefulWidget {
  @override
  _StepperPageState createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  @override
  Widget build(BuildContext context) {
    return FSafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.runtimeType.toString()),
      ),
      body: Stepper(
        onStepContinue: null,
        onStepCancel: null,
        steps: <Step>[
          Step(
            title: Text('title'),
            subtitle: Text('subtitle'),
            content: Text('content'),
            state: StepState.indexed,
            isActive: true,
          ),
          Step(
            title: Text('title'),
            subtitle: Text('subtitle'),
            content: Text('content'),
            state: StepState.editing,
            isActive: true,
          ),
          Step(
            title: Text('title'),
            subtitle: Text('subtitle'),
            content: Text('content'),
            state: StepState.complete,
            isActive: true,
          ),
          Step(
            title: Text('title'),
            subtitle: Text('subtitle'),
            content: Text('content'),
            state: StepState.disabled,
            isActive: true,
          ),
          Step(
            title: Text('title'),
            subtitle: Text('subtitle'),
            content: Text('content'),
            state: StepState.error,
            isActive: true,
          ),
        ],
      ),
    ));
  }
}
