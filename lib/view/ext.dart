import 'package:flutter/material.dart';

abstract class FInstanceBuilder<T> {
  T build();
}

abstract class FWidgetBuilder<T extends Widget> extends FInstanceBuilder<T> {
  Key key;
}

abstract class FChildWidgetBuilder<T extends Widget> extends FWidgetBuilder<T> {
  Widget child;
}
