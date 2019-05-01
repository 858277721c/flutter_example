import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/dialog/flib_dialog.dart';

class DialogPage extends StatefulWidget {
  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  final FDialog dialogConfirm = FDialog();
  final FDialog dialogProgress = FDialog();
  final FDialogBuilder dialogBuilder = FDialogBuilder();

  @override
  void initState() {
    super.initState();
    dialogConfirm.onDismissListener = () {
      print('DialogPage dialogConfirm dismissed');
    };
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = [];

    list.add(FButton.raised(
      onPressed: () {
        showConfirmDialog();
      },
      child: Text('showConfirmDialog'),
    ));

    list.add(FButton.raised(
      onPressed: () {
        showProgressDialog();
      },
      child: Text('showProgressDialog'),
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
    dialogConfirm.show(
        context: context,
        widget: FDialogConfirmView.simple(
          title: 'title',
          content: 'content',
          cancel: 'cancel',
          cancelOnPressed: () {
            dialogConfirm.dismiss();
            print('DialogPage onPressed cancel');
          },
          confirm: 'confirm',
          confirmOnPressed: () {
            dialogConfirm.dismiss();
            print('DialogPage onPressed confirm');
          },
        ));
  }

  void showProgressDialog() {
    dialogProgress.show(
      context: context,
      widget: dialogBuilder.build(
        FDialogProgressView(
          content: '加载中...',
        ),
        context,
      ),
    );
  }
}
