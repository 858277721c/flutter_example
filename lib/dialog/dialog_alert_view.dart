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
  })  : assert(content != null),
        this.dialogBuilder = dialogBuilder ?? FDialogBuilder();

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
    final List<Widget> list = [];

    if (title != null) {
      list.add(transformTitle(
        widget: title,
        context: context,
      ));
    }

    list.add(transformContent(
      widget: content,
      context: context,
    ));

    if (actions != null && actions.isNotEmpty) {
      if (actionsDividerTop == null) {
        list.add(Container(
          color: Color(0xFF9999),
          width: double.infinity,
          height: 0.5,
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
