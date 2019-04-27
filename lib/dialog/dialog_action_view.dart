import 'package:flutter/material.dart';

class FDialogAction extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final TextStyle textStyle;

  final AlignmentGeometry alignment;

  FDialogAction({
    this.child,
    this.onPressed,
    this.textStyle,
    this.alignment = Alignment.center,
  });

  factory FDialogAction.simple(
    String text, {
    VoidCallback onPressed,
  }) {
    return FDialogAction(
      child: Text(text),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);

    final TextStyle targetTextStyle = textStyle ??
        dialogTheme.contentTextStyle ??
        theme.textTheme.subhead ??
        TextStyle(
          fontSize: 14,
          color: Color(0xFF666666),
        );

    return InkWell(
      onTap: onPressed,
      child: DefaultTextStyle(
        style: targetTextStyle,
        child: Container(
          alignment: alignment,
          child: child,
        ),
      ),
    );
  }
}
