import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/dialog/flib_dialog.dart';

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
                          return FDialogConfirmView.simple(
                            title: 'title',
                            content: 'content',
                            cancel: 'cancel',
                            cancelOnPressed: () {
                              print('DialogPage onPressed cancel');
                            },
                            confirm: 'confirm',
                            confirmOnPressed: () {
                              print('DialogPage onPressed confirm');
                            },
                          );
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
