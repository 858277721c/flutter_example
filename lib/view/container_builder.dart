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

  FBContainer copyWith({
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
    final FBContainer copy = FBContainer();
    copy.key = key ?? this.key;
    copy.alignment = alignment ?? this.alignment;
    copy.padding = padding ?? this.padding;
    copy.color = color ?? this.color;
    copy.decoration = decoration ?? this.decoration;
    copy.foregroundDecoration =
        foregroundDecoration ?? this.foregroundDecoration;
    copy.width = width ?? this.width;
    copy.height = height ?? this.height;
    copy.constraints = constraints ?? this.constraints;
    copy.margin = margin ?? this.margin;
    copy.transform = transform ?? this.transform;
    copy.child = child ?? this.child;
    return copy;
  }

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
