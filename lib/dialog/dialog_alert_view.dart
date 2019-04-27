import 'package:flutter/material.dart';

import 'dialog_view.dart';

class FDialogAlertView extends StatelessWidget {
  final Widget title;
  final Widget content;

  final List<Widget> actions;
  final Widget actionsDividerTop;
  final Widget actionsDivider;

  final FDialogBuilder dialogBuilder;

  FDialogAlertView({
    this.title,
    this.content,
    this.actions,
    this.actionsDividerTop,
    this.actionsDivider,
    FDialogBuilder dialogBuilder,
  }) : this.dialogBuilder = dialogBuilder ?? FDialogBuilder();

  Widget transformTitle({@required Widget widget, BuildContext context}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: widget,
    );
  }

  Widget transformContent({@required Widget widget, BuildContext context}) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: widget,
    );
  }

  Widget transformActions(
      {@required List<Widget> widgets, BuildContext context}) {
    final List<Widget> list = [];

    for (int i = 0; i < widgets.length; i++) {
      final Widget item = widgets[i];
      list.add(Expanded(child: item));

//      if (i < widgets.length - 1) {
//        list.add(Container(
//          color: Color(0xFF9999),
//          width: 0.5,
//          height: double.infinity,
//        ));
//      }
    }

    return Row(
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);

    final List<Widget> list = [];

    if (title != null) {
      final Widget titleTransform = transformTitle(
        widget: title,
        context: context,
      );

      final TextStyle titleTextStyle = dialogTheme.titleTextStyle ??
          theme.textTheme.title ??
          TextStyle(
            fontSize: 16,
            color: Color(0xFF333333),
          );

      list.add(DefaultTextStyle(
        style: titleTextStyle,
        child: titleTransform,
      ));
    }

    if (content != null) {
      final Widget contentTransform = transformContent(
        widget: content,
        context: context,
      );

      final TextStyle contentTextStyle = dialogTheme.contentTextStyle ??
          theme.textTheme.subhead ??
          TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          );

      list.add(DefaultTextStyle(
        style: contentTextStyle,
        child: contentTransform,
      ));
    }

    if (actions != null && actions.isNotEmpty) {
      if (actionsDividerTop == null) {
        list.add(Container(
          color: Color(0xFF999999),
          width: double.infinity,
          height: 0.3,
        ));
      } else {
        list.add(actionsDividerTop);
      }

      list.add(transformActions(
        widgets: actions,
        context: context,
      ));
    }

    final Column column = Column(
      mainAxisSize: MainAxisSize.min,
      children: list,
    );

    return dialogBuilder.build(column, context);
  }
}
