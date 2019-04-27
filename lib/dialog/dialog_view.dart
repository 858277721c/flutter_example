import 'package:flutter/material.dart';

class FDialogBuilder {
  final Color backgroundColor;
  final double elevation;
  final ShapeBorder shape;

  final EdgeInsets padding;
  final AlignmentGeometry alignment;

  FDialogBuilder({
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.padding,
    this.alignment = Alignment.center,
  });

  static const RoundedRectangleBorder _defaultDialogShape =
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)));

  static const double _defaultElevation = 24.0;
  static const double _defaultPaddingWidthPercent = 0.1;

  Widget build(Widget child, BuildContext context) {
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

    final Material material = Material(
      color: targetBackgroundColor,
      elevation: targetElevation,
      shape: targetShape,
      type: MaterialType.card,
      child: child,
    );

    return Container(
      alignment: alignment,
      padding: targetPadding,
      child: material,
    );
  }
}
