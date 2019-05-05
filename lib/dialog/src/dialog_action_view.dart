import 'package:flutter/material.dart';

class FDialogAction extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

  FDialogAction({
    this.child,
    this.onPressed,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.only(
      left: 10,
      right: 10,
    ),
    this.borderRadius = BorderRadius.zero,
  });

  factory FDialogAction.simple(
    String text, {
    VoidCallback onPressed,
    AlignmentGeometry alignment,
    EdgeInsets padding,
  }) {
    return FDialogAction(
      child: Text(text),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      onTap: onPressed,
      child: Container(
        padding: padding,
        alignment: alignment,
        child: child,
      ),
    );
  }
}
