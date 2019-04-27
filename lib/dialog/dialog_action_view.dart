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
    this.alignment,
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

    return Container(
      child: InkWell(
        onTap: onPressed,
        child: DefaultTextStyle(
          style: textStyle ??
              dialogTheme.contentTextStyle ??
              theme.textTheme.subhead ??
              TextStyle(
                fontSize: 13,
                color: Color(0xFF666666),
              ),
          child: child,
        ),
      ),
    );
  }
}
