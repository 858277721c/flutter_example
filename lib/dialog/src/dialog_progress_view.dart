import 'package:flutter/material.dart';

import 'dialog.dart';
import 'dialog_view_wrapper.dart';

class FDialogProgressView extends StatelessWidget implements FDialogView {
  final String content;
  final double progressSize;
  final double padding;
  final TextStyle textStyle;

  FDialogProgressView({
    this.content,
    this.progressSize = 26,
    this.padding = 13,
    this.textStyle,
  });

  @override
  void applyDialog(FDialog dialog) {
    if (dialog.dialogViewWrapper == null) {
      dialog.dialogViewWrapper = FSimpleDialogViewWrapper();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = [];

    list.add(SizedBox(
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
      width: progressSize,
      height: progressSize,
    ));

    if (content != null) {
      list.add(SizedBox(
        height: 10,
      ));
    }

    if (content != null) {
      list.add(Text(
        content,
        style: textStyle ??
            TextStyle(
              fontSize: 13,
              color: const Color(0xFF333333),
            ),
      ));
    }

    return Container(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: list,
      ),
    );
  }
}
