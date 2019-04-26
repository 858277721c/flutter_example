import 'package:flutter/material.dart';

import 'ext.dart';

class FBContainer extends FChildWidgetBuilder {
  AlignmentGeometry alignment;
  EdgeInsetsGeometry padding;
  Color color;
  Decoration decoration;
  Decoration foregroundDecoration;
  double width;
  double height;
  BoxConstraints constraints;
  EdgeInsetsGeometry margin;
  Matrix4 transform;

  Container build({
    Key key,
    AlignmentGeometry alignment,
    EdgeInsetsGeometry padding,
    Color color,
    Decoration decoration,
    Decoration foregroundDecoration,
    double width,
    double height,
    BoxConstraints constraints,
    EdgeInsetsGeometry margin,
    Matrix4 transform,
    Widget child,
  }) {
    return Container(
      key: key ?? this.key,
      alignment: alignment ?? this.alignment,
      padding: padding ?? this.padding,
      color: color ?? this.color,
      decoration: decoration ?? this.decoration,
      foregroundDecoration: foregroundDecoration ?? this.foregroundDecoration,
      width: width ?? this.width,
      height: height ?? this.height,
      constraints: constraints ?? this.constraints,
      margin: margin ?? this.margin,
      transform: transform ?? this.transform,
      child: child ?? this.child,
    );
  }
}
