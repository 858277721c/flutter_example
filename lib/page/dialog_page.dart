import 'package:flib_builder/flib_builder.dart';
import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    return FSafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              FButton.raised(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return FDialogConfirmView.simple(
                            title: FDialogActionView.simple('title'),
                            content: FDialogActionView.simple('content'),
                            cancel: FDialogActionView.simple('cancel'),
                            confirm: FDialogActionView.simple('confirm'),
                          );
                        });
                  },
                  child: Text('FDialogConfirmView')),
            ],
          ),
        ),
      ),
    );
  }
}

class FDialogAlertView extends StatelessWidget {
  final FContainerBuilder root = FContainerBuilder();

  final Widget title;
  final Widget content;

  final List<Widget> actions;
  final Widget actionsDividerTop;
  final Widget actionsDivider;

  FDialogAlertView({
    this.title,
    this.content,
    this.actions,
    this.actionsDividerTop,
    this.actionsDivider,
  }) : assert(content != null) {
    root.decoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    );
  }

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
        list.add(Container(
          color: Color(0xFF9999),
          width: 0.5,
          height: double.infinity,
        ));
      }
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

    return root.build(
        child: Column(
      children: list,
    ));
  }
}

class FDialogActionView extends StatelessWidget {
  final FContainerBuilder container = FContainerBuilder();
  final FTextBuilder text = FTextBuilder();
  final VoidCallback onPressed;

  FDialogActionView(this.onPressed);

  factory FDialogActionView.simple(
    String text, {
    VoidCallback onPressed,
  }) {
    final FDialogActionView actionView = FDialogActionView(onPressed);
    actionView.container.alignment = Alignment.center;
    actionView.text.data = text;
    return actionView;
  }

  @override
  Widget build(BuildContext context) {
    return container.build(
      child: GestureDetector(
        onTap: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        child: text.build(),
      ),
    );
  }
}

class FDialogConfirmView extends StatelessWidget {
  final FDialogActionView title;
  final FDialogActionView content;
  final FDialogActionView cancel;
  final FDialogActionView confirm;

  FDialogConfirmView({
    this.title,
    this.content,
    this.cancel,
    this.confirm,
  });

  factory FDialogConfirmView.simple({
    FDialogActionView title,
    FDialogActionView content,
    FDialogActionView cancel,
    FDialogActionView confirm,
  }) {
    final FDialogConfirmView confirmView = FDialogConfirmView(
      title: title,
      content: content,
      cancel: cancel,
      confirm: confirm,
    );

    if (confirmView.title != null) {
      confirmView.title.text.style = TextStyle(
        fontSize: 16,
        color: Color(0xFF333333),
      );
    }

    if (confirmView.content != null) {
      confirmView.content.text.style = TextStyle(
        fontSize: 14,
        color: Color(0xFF666666),
      );
    }

    if (confirmView.cancel != null) {
      confirmView.cancel.text.style = TextStyle(
        fontSize: 14,
        color: Color(0xFF999999),
      );
    }

    if (confirmView.confirm != null) {
      confirmView.confirm.text.style = TextStyle(
        fontSize: 14,
        color: Color(0xFF666666),
      );
    }

    return confirmView;
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
