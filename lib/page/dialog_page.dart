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
                          return FDialogAlertView.simple(
                            title: 'title',
                            content: 'content',
                            cancel: 'cancel',
                            confirm: 'confirm',
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
  final Widget title;
  final Widget content;

  final List<Widget> actions;
  final Widget actionsDivider;

  FDialogAlertView({
    this.title,
    this.content,
    this.actions,
    this.actionsDivider,
  });

  factory FDialogAlertView.simple({
    String title,
    String content,
    String cancel,
    String confirm,
    VoidCallback cancelOnPressed,
    VoidCallback confirmOnPressed,
  }) {
    final Widget widgetTitle = title == null
        ? null
        : Text(
            title,
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 16,
            ),
          );

    content ??= '';
    final Widget widgetContent = Text(
      content,
      style: TextStyle(
        color: Color(0xFF666666),
        fontSize: 13,
      ),
    );

    final List<Widget> widgetAcions = [];
    if (cancel != null) {
      widgetAcions.add(FlatButton(
          onPressed: () {
            if (cancelOnPressed != null) {
              cancelOnPressed();
            }
          },
          child: Text(
            cancel,
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 14,
            ),
          )));
    }

    if (confirm != null) {
      widgetAcions.add(FlatButton(
          onPressed: () {
            if (confirmOnPressed != null) {
              confirmOnPressed();
            }
          },
          child: Text(
            confirm,
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 14,
            ),
          )));
    }

    return FDialogAlertView(
      title: widgetTitle,
      content: widgetContent,
      actions: widgetAcions,
    );
  }

  Widget transformRoot({@required Widget widget, BuildContext context}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: widget,
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

    list.add(Container(
      color: Color(0xFF9999),
      width: double.infinity,
      height: 0.5,
    ));

    list.add(transformActions(
      widgets: actions,
      context: context,
    ));

    final Column root = Column(
      children: list,
    );

    return transformRoot(
      widget: root,
      context: context,
    );
  }
}
