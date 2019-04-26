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
    @required VoidCallback onPressed,
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

  FlatButton build({
    Key key,
    @required VoidCallback onPressed,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior = Clip.none,
    MaterialTapTargetSize materialTapTargetSize,
    @required Widget child,
  }) {
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
      child: child ?? this.child,
    );
  }
}

class FBRaisedButton extends FChildWidgetBuilder {
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

  double elevation;
  double highlightElevation;
  double disabledElevation;
  Duration animationDuration;

  RaisedButton build({
    Key key,
    @required VoidCallback onPressed,
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
    Widget child,
  }) {
    return RaisedButton(
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
      child: child ?? this.child,
      elevation: elevation ?? this.elevation,
      highlightElevation: highlightElevation ?? this.highlightElevation,
      disabledElevation: disabledElevation ?? this.disabledElevation,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }
}

class FBOutlineButton extends FChildWidgetBuilder {
  VoidCallback onPressed;
  ButtonTextTheme textTheme;
  Color textColor;
  Color disabledTextColor;
  Color color;
  Color highlightColor;
  Color splashColor;
  double highlightElevation;
  BorderSide borderSide;
  Color disabledBorderColor;
  Color highlightedBorderColor;
  EdgeInsetsGeometry padding;
  ShapeBorder shape;
  Clip clipBehavior = Clip.none;

  OutlineButton build({
    Key key,
    @required VoidCallback onPressed,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color highlightColor,
    Color splashColor,
    double highlightElevation,
    BorderSide borderSide,
    Color disabledBorderColor,
    Color highlightedBorderColor,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior = Clip.none,
    Widget child,
  }) {
    return OutlineButton(
      key: key ?? this.key,
      onPressed: onPressed ?? this.onPressed,
      textTheme: textTheme ?? this.textTheme,
      textColor: textColor ?? this.textColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      color: color ?? this.color,
      highlightColor: highlightColor ?? this.highlightColor,
      splashColor: splashColor ?? this.splashColor,
      highlightElevation: highlightElevation ?? this.highlightElevation,
      borderSide: borderSide ?? this.borderSide,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      highlightedBorderColor:
          highlightedBorderColor ?? this.highlightedBorderColor,
      padding: padding ?? this.padding,
      shape: shape ?? this.shape,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      child: child ?? this.child,
    );
  }

  OutlineButton buildIcon({
    Key key,
    @required VoidCallback onPressed,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color highlightColor,
    Color splashColor,
    double highlightElevation,
    Color highlightedBorderColor,
    Color disabledBorderColor,
    BorderSide borderSide,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior,
    @required Widget icon,
    @required Widget label,
  }) {
    return OutlineButton.icon(
      key: key ?? this.key,
      onPressed: onPressed ?? this.onPressed,
      textTheme: textTheme ?? this.textTheme,
      textColor: textColor ?? this.textColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      color: color ?? this.color,
      highlightColor: highlightColor ?? this.highlightColor,
      splashColor: splashColor ?? this.splashColor,
      highlightElevation: highlightElevation ?? this.highlightElevation,
      highlightedBorderColor:
          highlightedBorderColor ?? this.highlightedBorderColor,
      borderSide: borderSide ?? this.borderSide,
      padding: padding ?? this.padding,
      shape: shape ?? this.shape,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      icon: icon,
      label: label,
    );
  }
}
