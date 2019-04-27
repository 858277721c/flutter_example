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
    this.alignment,
  });

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

    return SafeArea(
        child: Container(
      alignment: alignment,
      width: width ??
          mediaQueryData.size.width *
              mediaQueryData.devicePixelRatio *
              _defaultWidthPercent,
      height: height ?? null,
      child: Material(
        color: backgroundColor ??
            dialogTheme.backgroundColor ??
            Theme.of(context).dialogBackgroundColor ??
            Colors.white,
        elevation: elevation ?? dialogTheme.elevation ?? _defaultElevation,
        shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
        type: MaterialType.card,
        child: child,
      ),
    ));
  }
}
