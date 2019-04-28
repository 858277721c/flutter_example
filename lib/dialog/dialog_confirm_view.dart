import 'package:flutter/material.dart';

import 'dialog_action_view.dart';
import 'dialog_alert_view.dart';
import 'dialog_view.dart';

class FDialogConfirmView extends StatelessWidget {
  final Widget title;
  final Widget content;
  final FDialogAction cancel;
  final FDialogAction confirm;

  final FDialogBuilder dialogBuilder;

  FDialogConfirmView({
    this.title,
    this.content,
    this.cancel,
    this.confirm,
    this.dialogBuilder,
  });

  factory FDialogConfirmView.simple({
    String title,
    String content,
    String cancel,
    VoidCallback cancelOnPressed,
    String confirm,
    VoidCallback confirmOnPressed,
    FDialogBuilder dialogBuilder,
  }) {
    Widget titleWidget;

    if (title != null) {
      titleWidget = Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    Widget contentWidget;
    if (content != null) {
      contentWidget = Text(
        content,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    FDialogAction cancelWidget;
    if (cancel != null) {
      cancelWidget = FDialogAction(
        child: Text(
          cancel,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onPressed: cancelOnPressed,
      );
    }

    FDialogAction confirmWidget;
    if (confirm != null) {
      confirmWidget = FDialogAction(
        child: Text(
          confirm,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onPressed: confirmOnPressed,
      );
    }

    return FDialogConfirmView(
      title: titleWidget,
      content: contentWidget,
      cancel: cancelWidget,
      confirm: confirmWidget,
      dialogBuilder: dialogBuilder,
    );
  }

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
