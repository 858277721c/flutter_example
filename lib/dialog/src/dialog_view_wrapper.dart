import 'package:flutter/material.dart';

import 'dialog.dart';

class FSimpleDialogViewWrapper implements FDialogViewWrapper {
  final Color backgroundColor;
  final double elevation;
  final ShapeBorder shape;

  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;

  FSimpleDialogViewWrapper({
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.padding,
    this.alignment = Alignment.center,
  });

  static const RoundedRectangleBorder _defaultDialogShape =
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)));

  static const double _defaultElevation = 0;
  static const double _defaultPaddingWidthPercent = 0.1;

  @override
  Widget wrap(BuildContext context, Widget child) {
    assert(child != null);
    assert(context != null);

    final DialogTheme dialogTheme = DialogTheme.of(context);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    final Color targetBackgroundColor = backgroundColor ??
        dialogTheme.backgroundColor ??
        Theme.of(context).dialogBackgroundColor ??
        Colors.white;

    final double targetElevation =
        elevation ?? dialogTheme.elevation ?? _defaultElevation;

    final ShapeBorder targetShape =
        shape ?? dialogTheme.shape ?? _defaultDialogShape;

    final EdgeInsets targetPadding = padding ??
        EdgeInsets.all(mediaQueryData.size.width * _defaultPaddingWidthPercent);

    Widget current = Material(
      color: targetBackgroundColor,
      elevation: targetElevation,
      shape: targetShape,
      type: MaterialType.card,
      child: child,
    );

    current = Container(
      alignment: alignment,
      padding: targetPadding,
      child: current,
    );

    if (targetPadding.left == 0 &&
        targetPadding.top == 0 &&
        targetPadding.right == 0 &&
        targetPadding.bottom == 0) {
      current = SafeArea(child: current);
    }

    return current;
  }
}
