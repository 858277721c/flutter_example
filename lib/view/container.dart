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
