import 'package:flutter/material.dart';

class FDialogAction extends StatelessWidget {
  final Widget child;
  final VoidCallback onClick;

  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

  FDialogAction({
    this.child,
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
    return InkWell(
      borderRadius: borderRadius,
      onTap: onClick,
      child: Container(
        padding: padding,
        alignment: alignment,
        child: child,
      ),
    );
  }
}
