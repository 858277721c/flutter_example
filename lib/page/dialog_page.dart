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
        context: context,
        content: Text('我是内容'),
        cancelOnPressed: () {
          dialogConfirm.dismiss();
          print('DialogPage onPressed cancel');
        },
        confirmOnPressed: () {
          dialogConfirm.dismiss();
          print('DialogPage onPressed confirm');
        },
      ),
    );
  }

  void showProgressDialog() {
    dialogProgress.show(
      context: context,
      widget: FDialogProgressView(
        content: '加载中...',
      ),
    );
  }
}
