import 'package:flutter/material.dart';

class FDialogBuilder {
  final Color backgroundColor;
  final double elevation;
  final ShapeBorder shape;

  final double width;
  final double height;
  final AlignmentGeometry alignment;

  FDialogBuilder({
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.width,
    this.height,
    AlignmentGeometry alignment,
  }) : this.alignment = alignment ?? Alignment.center;

  static const RoundedRectangleBorder _defaultDialogShape =
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)));

  static const double _defaultElevation = 24.0;
  static const double _defaultWidthPercent = 0.8;

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

    final double targetWidth = width ??
        mediaQueryData.size.width *
            mediaQueryData.devicePixelRatio *
            _defaultWidthPercent;

    final Material material = Material(
      color: targetBackgroundColor,
      elevation: targetElevation,
      shape: targetShape,
      type: MaterialType.card,
      child: child,
    );

    return SafeArea(
      child: Align(
        alignment: alignment,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: targetWidth,
            maxWidth: targetWidth,
          ),
          child: material,
        ),
      ),
    );
  }
}
