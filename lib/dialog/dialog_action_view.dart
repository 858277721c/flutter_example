import 'package:flutter/material.dart';

class FDialogAction extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  final AlignmentGeometry alignment;

  FDialogAction({
    this.child,
    this.onPressed,
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
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: alignment,
        child: child,
      ),
    );
  }
}
