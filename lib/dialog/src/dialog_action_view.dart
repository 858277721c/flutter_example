import 'package:flutter/material.dart';

class FDialogAction extends StatelessWidget {
  final Widget child;
  final TextStyle textStyle;
  final VoidCallback onClick;

  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

  FDialogAction({
    this.child,
    this.textStyle,
    this.onClick,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.only(
      left: 10,
      right: 10,
    ),
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);

    final TextStyle targetTextStyle = textStyle ??
        dialogTheme.contentTextStyle ??
        TextStyle(
          fontSize: 14,
          color: Color(0xFF666666),
        );

    return InkWell(
      borderRadius: borderRadius,
      onTap: onClick,
      child: Container(
        padding: padding,
        alignment: alignment,
        child: DefaultTextStyle(
          style: targetTextStyle,
          child: child,
        ),
      ),
    );
  }
}
