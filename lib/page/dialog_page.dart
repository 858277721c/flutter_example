import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    return FSafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              FButton.raised(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return FDialogConfirmView();
                        });
                  },
                  child: Text('FDialogConfirmView')),
            ],
          ),
        ),
      ),
    );
  }
}

class FDialogConfirmView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
