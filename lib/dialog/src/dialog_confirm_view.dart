import 'package:flutter/material.dart';

import 'dialog.dart';
import 'dialog_action_view.dart';
import 'dialog_alert_view.dart';
import 'locale.dart';

class FDialogConfirmView extends StatelessWidget with FDialogViewMixin {
  final Widget title;
  final Widget content;
  final FDialogAction cancel;
  final FDialogAction confirm;

  FDialogConfirmView({
    this.title,
    this.content,
    this.cancel,
    this.confirm,
  });

  factory FDialogConfirmView.simple({
    String title = '',
    Widget content,
    String cancel = '',
    VoidCallback onClickCancel,
    String confirm = '',
    VoidCallback onClickConfirm,
    @required BuildContext context,
  }) {
    Widget widgetTitle;
    if (title != null) {
      if (title == '') {
        title = FLibDialogLocale.tips(context);
      }

      widgetTitle = Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    Widget widgetContent = content;

    FDialogAction widgetCancel;
    if (cancel != null) {
      if (cancel == '') {
        cancel = FLibDialogLocale.cancel(context);
      }

      widgetCancel = FDialogAction(
        child: Text(
          cancel,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onClick: onClickCancel,
        borderRadius: confirm == null
            ? BorderRadius.only(
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              )
            : BorderRadius.only(bottomLeft: Radius.circular(5.0)),
      );
    }

    FDialogAction widgetConfirm;
    if (confirm != null) {
      if (confirm == '') {
        confirm = FLibDialogLocale.confirm(context);
      }

      widgetConfirm = FDialogAction(
        child: Text(
          confirm,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onClick: onClickConfirm,
        borderRadius: cancel == null
            ? BorderRadius.only(
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              )
            : BorderRadius.only(bottomRight: Radius.circular(5.0)),
      );
    }

    return FDialogConfirmView(
      title: widgetTitle,
      content: widgetContent,
      cancel: widgetCancel,
      confirm: widgetConfirm,
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
    );
  }
}
