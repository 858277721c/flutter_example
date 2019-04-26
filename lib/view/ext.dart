import 'package:flutter/material.dart';

abstract class FWidgetBuilder {
  Key key;
}

abstract class FChildWidgetBuilder extends FWidgetBuilder {
  Widget child;
}
