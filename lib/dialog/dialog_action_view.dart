import 'package:flutter/material.dart';

class FDialogAction extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  final AlignmentGeometry alignment;
  final EdgeInsets padding;

  FDialogAction({
    this.child,
    this.onPressed,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.only(
      left: 10,
      right: 10,
    ),
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
      onTap: onPressed,
      child: Container(
        padding: padding,
        alignment: alignment,
        child: child,
      ),
    );
  }
}
