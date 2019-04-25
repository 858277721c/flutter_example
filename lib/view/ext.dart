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

  FValueHolder<Key> get key => _key;
}

class FWidget_child {
  FValueHolder<Widget> _child;

  FValueHolder<Widget> get child => _child;
}

class FDouble_width {
  FValueHolder<double> _width;

  FValueHolder<double> get width => _width;
}

class FDouble_height {
  FValueHolder<double> _height;

  FValueHolder<double> get height => _height;
}

class FEdgeInsets_margin {
  FValueHolder<EdgeInsets> _margin;

  FValueHolder<EdgeInsets> get margin => _margin;
}

class FEdgeInsets_padding {
  FValueHolder<EdgeInsets> _padding;

  FValueHolder<EdgeInsets> get padding => _padding;
}

class FAlignment_alignment {
  FValueHolder<Alignment> _alignment;

  FValueHolder<Alignment> get alignment => _alignment;
}

class FColor_color {
  FValueHolder<Color> _color;

  FValueHolder<Color> get color => _color;
}

class FDecoration_decoration {
  FValueHolder<Decoration> _decoration;

  FValueHolder<Decoration> get decoration => _decoration;
}

class FDecoration_foregroundDecoration {
  FValueHolder<Decoration> _foregroundDecoration;

  FValueHolder<Decoration> get foregroundDecoration => _foregroundDecoration;
}

class FBoxConstraints_constraints {
  FValueHolder<BoxConstraints> _constraints;

  FValueHolder<BoxConstraints> get constraints => _constraints;
}

class FMatrix4_transform {
  FValueHolder<Matrix4> _transform;

  FValueHolder<Matrix4> get transform => _transform;
}

abstract class FWidgetBuilder with FKey_key {
  Widget build();
}

abstract class FChildWidgetBuilder extends FWidgetBuilder with FWidget_child {}
