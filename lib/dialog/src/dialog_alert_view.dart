import 'package:flutter/material.dart';

import 'dialog.dart';

class FDialogAlertView extends StatelessWidget with FDialogViewMixin {
  final Widget title;
  final TextStyle titleTextStyle;

  final Widget content;
  final TextStyle contentTextStyle;
  final EdgeInsetsGeometry contentPadding;

  final List<Widget> actions;
  final Widget actionsDividerTop;
  final Widget actionsDivider;
  final double actionsHeight;

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
  });

  Widget wrapTitle(Widget widget) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: widget,
    );
  }

  Widget wrapContent(Widget widget) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
        bottom: 15,
      ),
      child: widget,
    );
  }

  Widget transformActions(List<Widget> widgets, BuildContext context) {
    final List<Widget> list = [];

    for (int i = 0; i < widgets.length; i++) {
      final Widget item = widgets[i];
      list.add(Expanded(child: item));

      if (i < widgets.length - 1) {
        list.add(buildActionsDivider());
      }
    }

    return Row(
      children: list,
    );
  }

  Widget buildActionsTopDivider() {
    return Container(
      color: Color(0xFF999999),
      width: double.infinity,
      height: 0.3,
    );
  }

  Widget buildActionsDivider() {
    return Container(
      color: Color(0xFF999999),
      width: 0.3,
      height: double.infinity,
    );
  }

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);

    final List<Widget> list = [];

    if (title != null) {
      final Widget widgetTitle = wrapTitle(title);

      final TextStyle targetTextStyle = titleTextStyle ??
          dialogTheme.titleTextStyle ??
          TextStyle(
            fontSize: 16,
            color: Color(0xFF333333),
          );

      list.add(DefaultTextStyle(
        style: targetTextStyle,
        child: widgetTitle,
      ));
    }

    if (content != null) {
      Widget widgetContent = wrapContent(content);

      final EdgeInsetsGeometry targetPadding = contentPadding ??
          EdgeInsets.only(
            left: 10,
            right: 10,
          );

      widgetContent = Padding(
        padding: targetPadding,
        child: widgetContent,
      );

      final TextStyle targetTextStyle = contentTextStyle ??
          dialogTheme.contentTextStyle ??
          TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          );

      list.add(DefaultTextStyle(
        style: targetTextStyle,
        child: widgetContent,
      ));
    }

    if (actions != null && actions.isNotEmpty) {
      if (actionsDividerTop == null) {
        list.add(buildActionsTopDivider());
      } else {
        list.add(actionsDividerTop);
      }

      final Widget actionsTransform = transformActions(
        actions,
        context,
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

    return column;
  }
}
