import 'package:flutter/material.dart';

import 'ext.dart';

class FBMaterialButton extends FChildWidgetBuilder {
  VoidCallback onPressed;
  ValueChanged<bool> onHighlightChanged;
  ButtonTextTheme textTheme;
  Color textColor;
  Color disabledTextColor;
  Color color;
  Color disabledColor;
  Color highlightColor;
  Color splashColor;
  Brightness colorBrightness;
  double elevation;
  double highlightElevation;
  double disabledElevation;
  EdgeInsetsGeometry padding;
  ShapeBorder shape;
  Clip clipBehavior = Clip.none;
  MaterialTapTargetSize materialTapTargetSize;
  Duration animationDuration;
  double minWidth;
  double height;

  MaterialButton build({
    Key key,
    VoidCallback onPressed,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    double elevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior = Clip.none,
    MaterialTapTargetSize materialTapTargetSize,
    Duration animationDuration,
    double minWidth,
    double height,
    Widget child,
  }) {
    return MaterialButton(
      key: key ?? this.key,
      onPressed: onPressed ?? this.onPressed,
      onHighlightChanged: onHighlightChanged ?? this.onHighlightChanged,
      textTheme: textTheme ?? this.textTheme,
      textColor: textColor ?? this.textColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      color: color ?? this.color,
      disabledColor: disabledColor ?? this.disabledColor,
      highlightColor: highlightColor ?? this.highlightColor,
      splashColor: splashColor ?? this.splashColor,
      colorBrightness: colorBrightness ?? this.colorBrightness,
      elevation: elevation ?? this.elevation,
      highlightElevation: highlightElevation ?? this.highlightElevation,
      disabledElevation: disabledElevation ?? this.disabledElevation,
      padding: padding ?? this.padding,
      shape: shape ?? this.shape,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      materialTapTargetSize:
          materialTapTargetSize ?? this.materialTapTargetSize,
      animationDuration: animationDuration ?? this.animationDuration,
      minWidth: minWidth ?? this.minWidth,
      height: height ?? this.height,
      child: child ?? this.child,
    );
  }
}

class FBFlatButton extends FChildWidgetBuilder {
  VoidCallback onPressed;
  ValueChanged<bool> onHighlightChanged;
  ButtonTextTheme textTheme;
  Color textColor;
  Color disabledTextColor;
  Color color;
  Color disabledColor;
  Color highlightColor;
  Color splashColor;
  Brightness colorBrightness;
  EdgeInsetsGeometry padding;
  ShapeBorder shape;
  Clip clipBehavior = Clip.none;
  MaterialTapTargetSize materialTapTargetSize;

  FlatButton build() {
    return FlatButton(
      key: key ?? this.key,
      onPressed: onPressed ?? this.onPressed,
      onHighlightChanged: onHighlightChanged ?? this.onHighlightChanged,
      textTheme: textTheme ?? this.textTheme,
      textColor: textColor ?? this.textColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      color: color ?? this.color,
      disabledColor: disabledColor ?? this.disabledColor,
      highlightColor: highlightColor ?? this.highlightColor,
      splashColor: splashColor ?? this.splashColor,
      colorBrightness: colorBrightness ?? this.colorBrightness,
      padding: padding ?? this.padding,
      shape: shape ?? this.shape,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      materialTapTargetSize:
          materialTapTargetSize ?? this.materialTapTargetSize,
    );
  }
}
