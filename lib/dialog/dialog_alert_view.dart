import 'package:flutter/material.dart';

import 'dialog_view.dart';

class FDialogAlertView extends StatelessWidget {
  final Widget title;
  final TextStyle titleTextStyle;

  final Widget content;
  final TextStyle contentTextStyle;
  final EdgeInsetsGeometry contentPadding;

  final List<Widget> actions;
  final Widget actionsDividerTop;
  final Widget actionsDivider;
  final double actionsHeight;

  final FDialogBuilder dialogBuilder;

  FDialogAlertView({
    this.title,
    this.titleTextStyle,
    this.content,
    this.contentTextStyle,
    this.contentPadding,
    this.actions,
    this.actionsDividerTop,
    this.actionsDivider,
    this.actionsHeight = 36,
    FDialogBuilder dialogBuilder,
  }) : this.dialogBuilder = dialogBuilder ?? FDialogBuilder();

  Widget transformTitle({@required Widget widget, BuildContext context}) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: widget,
    );
  }

  Widget transformContent({@required Widget widget, BuildContext context}) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
        bottom: 15,
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

      if (i < widgets.length - 1) {
        list.add(createActionsDivider());
      }
    }

    return Row(
      children: list,
    );
  }

  Widget createActionsDividerTop() {
    return Container(
      color: Color(0xFF999999),
      width: double.infinity,
      height: 0.3,
    );
  }

  Widget createActionsDivider() {
    return Container(
      color: Color(0xFF999999),
      width: 0.3,
      height: double.infinity,
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

      final TextStyle targetTextStyle = titleTextStyle ??
          dialogTheme.titleTextStyle ??
          theme.textTheme.title ??
          TextStyle(
            fontSize: 16,
            color: Color(0xFF333333),
          );

      list.add(DefaultTextStyle(
        style: targetTextStyle,
        child: titleTransform,
      ));
    }

    if (content != null) {
      Widget current = transformContent(
        widget: content,
        context: context,
      );

      final EdgeInsetsGeometry targetPadding = contentPadding ??
          EdgeInsets.only(
            left: 10,
            right: 10,
          );

      current = Padding(
        padding: targetPadding,
        child: current,
      );

      final TextStyle targetTextStyle = contentTextStyle ??
          dialogTheme.contentTextStyle ??
          theme.textTheme.subhead ??
          TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          );

      list.add(DefaultTextStyle(
        style: targetTextStyle,
        child: current,
      ));
    }

    if (actions != null && actions.isNotEmpty) {
      if (actionsDividerTop == null) {
        list.add(createActionsDividerTop());
      } else {
        list.add(actionsDividerTop);
      }

      final Widget actionsTransform = transformActions(
        widgets: actions,
        context: context,
      );

      list.add(SizedBox(
        child: actionsTransform,
        height: actionsHeight,
      ));
    }

    final Column column = Column(
      mainAxisSize: MainAxisSize.min,
      children: list,
    );

    return dialogBuilder.build(column, context);
  }
}
