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
    final List<Widget> list = [];

    list.add(FButton.raised(
      onPressed: () {
        showConfirmDialog();
      },
      child: Text('showConfirmDialog'),
    ));

    return FSafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: list,
          ),
        ),
      ),
    );
  }

  void showConfirmDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return FDialogConfirmView.simple(
            title: 'title',
            content: 'content',
            cancel: 'cancel',
            cancelOnPressed: () {
              Navigator.of(context).pop();
              print('DialogPage onPressed cancel');
            },
            confirm: 'confirm',
            confirmOnPressed: () {
              Navigator.of(context).pop();
              print('DialogPage onPressed confirm');
            },
          );
        });
  }
}
