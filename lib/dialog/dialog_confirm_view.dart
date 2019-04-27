import 'package:flutter/material.dart';

import 'dialog_action_view.dart';
import 'dialog_alert_view.dart';
import 'dialog_view.dart';

class FDialogConfirmView extends StatelessWidget {
  final FDialogAction title;
  final FDialogAction content;
  final FDialogAction cancel;
  final FDialogAction confirm;

  final FDialogBuilder dialogBuilder;

  FDialogConfirmView({
    this.title,
    this.content,
    this.cancel,
    this.confirm,
    this.dialogBuilder,
  }) : assert(content != null);

  @override
  Widget build(BuildContext context) {
    final List<Widget> listAction = [];

    if (cancel != null) {
      listAction.add(cancel);
    }

    if (confirm != null) {
      listAction.add(confirm);
    }

    return FDialogAlertView(
      title: title,
      content: content,
      actions: listAction,
      dialogBuilder: dialogBuilder,
    );
  }
}
