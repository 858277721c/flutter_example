import 'package:flutter/material.dart';

import 'ext.dart';

class FBContainer extends FChildWidgetBuilder<Container>
    with
        FAlignmentGeometry_alignment,
        FEdgeInsetsGeometry_padding,
        FColor_color,
        FDecoration_decoration,
        FDecoration_foregroundDecoration,
        FDouble_width,
        FDouble_height,
        FBoxConstraints_constraints,
        FEdgeInsetsGeometry_margin,
        FMatrix4_transform {
  @override
  void read(Container source) {
    assert(source != null);

    if (source.key != null) {
      this.key.value = source.key;
    }
    if (source.alignment != null) {
      this.alignment.value = source.alignment;
    }
    if (source.padding != null) {
      this.padding.value = source.padding;
    }
    if (source.decoration != null) {
      this.decoration.value = source.decoration;
    }
    if (source.foregroundDecoration != null) {
      this.foregroundDecoration.value = source.foregroundDecoration;
    }
    if (source.constraints != null) {
      this.constraints.value = source.constraints;
    }
    if (source.margin != null) {
      this.margin.value = source.margin;
    }
    if (source.transform != null) {
      this.transform.value = source.transform;
    }
    if (source.child != null) {
      this.child.value = source.child;
    }
  }

  @override
  Container build() {
    return Container(
      key: key.value,
      alignment: alignment.value,
      padding: padding.value,
      color: color.value,
      decoration: decoration.value,
      foregroundDecoration: foregroundDecoration.value,
      width: width.value,
      height: height.value,
      constraints: constraints.value,
      margin: margin.value,
      transform: transform.value,
      child: child.value,
    );
  }
}
