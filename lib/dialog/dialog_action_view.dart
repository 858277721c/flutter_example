import 'package:flutter/material.dart';

class FDialogAction extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final TextStyle textStyle;

  final AlignmentGeometry alignment;
  final double height;

  FDialogAction({
    this.child,
    this.onPressed,
    this.textStyle,
    AlignmentGeometry alignment,
    double height,
  })  : this.alignment = alignment ?? Alignment.center,
        this.height = height ?? 36;

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
          fontSize: 13,
          color: Color(0xFF666666),
        );

    return Container(
      height: height,
      alignment: alignment,
      child: InkWell(
        onTap: onPressed,
        child: DefaultTextStyle(
          style: targetTextStyle,
          child: child,
        ),
      ),
    );
  }
}
