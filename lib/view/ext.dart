import 'package:flutter/material.dart';

class FValueHolder<V> {
  V _value;

  V get value => _value;

  set value(V value) {
    _value = value;
  }
}

class FValuePropertyHolder<T> {}

class FKey_key {
  FValueHolder<Key> _key;

  FValueHolder<Key> get key => _key ??= FValueHolder();
}

class FWidget_child {
  FValueHolder<Widget> _child;

  FValueHolder<Widget> get child => _child ??= FValueHolder();
}

class FDouble_width {
  FValueHolder<double> _width;

  FValueHolder<double> get width => _width ??= FValueHolder();
}

class FDouble_height {
  FValueHolder<double> _height;

  FValueHolder<double> get height => _height ??= FValueHolder();
}

class FEdgeInsetsGeometry_margin {
  FValueHolder<EdgeInsetsGeometry> _margin;

  FValueHolder<EdgeInsetsGeometry> get margin => _margin ??= FValueHolder();
}

class FEdgeInsetsGeometry_padding {
  FValueHolder<EdgeInsetsGeometry> _padding;

  FValueHolder<EdgeInsetsGeometry> get padding => _padding ??= FValueHolder();
}

class FAlignmentGeometry_alignment {
  FValueHolder<AlignmentGeometry> _alignment;

  FValueHolder<AlignmentGeometry> get alignment =>
      _alignment ??= FValueHolder();
}

class FColor_color {
  FValueHolder<Color> _color;

  FValueHolder<Color> get color => _color ??= FValueHolder();
}

class FDecoration_decoration {
  FValueHolder<Decoration> _decoration;

  FValueHolder<Decoration> get decoration => _decoration ??= FValueHolder();
}

class FDecoration_foregroundDecoration {
  FValueHolder<Decoration> _foregroundDecoration;

  FValueHolder<Decoration> get foregroundDecoration =>
      _foregroundDecoration ??= FValueHolder();
}

class FBoxConstraints_constraints {
  FValueHolder<BoxConstraints> _constraints;

  FValueHolder<BoxConstraints> get constraints =>
      _constraints ??= FValueHolder();
}

class FMatrix4_transform {
  FValueHolder<Matrix4> _transform;

  FValueHolder<Matrix4> get transform => _transform ??= FValueHolder();
}

abstract class FInstanceBuilder<T> {
  void read(T source);

  T build();
}

abstract class FWidgetBuilder<T extends Widget> extends FInstanceBuilder<T>
    with FKey_key {}

abstract class FChildWidgetBuilder<T extends Widget> extends FWidgetBuilder<T>
    with FWidget_child {}
