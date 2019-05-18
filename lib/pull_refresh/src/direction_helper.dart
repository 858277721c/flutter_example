import 'package:flutter/material.dart';

import 'pull_refresh.dart';

abstract class DirectionHelper {
  final GlobalKey<_IndicatorWrapperState> key = GlobalKey();

  final FPullRefreshIndicator indicator;
  final FPullRefreshController controller;

  DirectionHelper(
    this.indicator,
    this.controller,
  )   : assert(indicator != null),
        assert(controller != null);

  Size _getIndicatorRealSize() {
    final _IndicatorWrapperState state = key.currentState;
    if (state != null && state.mounted) {
      return state.size;
    }
    return null;
  }

  Widget newWidget() {
    return _IndicatorWrapper(
      key: key,
      builder: (context) {
        return indicator.build(controller);
      },
    );
  }

  double getIndicatorSize();

  double getIndicatorOffset(double offset);

  double getRefreshSize() {
    double size = indicator.getRefreshSize();
    if (size == null) {
      size = getIndicatorSize();
    }
    return size;
  }

  Widget wrapPosition(Widget widget, double offset) {
    return Positioned(
      child: widget,
      top: getIndicatorOffset(offset),
    );
  }
}

abstract class _VerticalHelper extends DirectionHelper {
  _VerticalHelper(
    FPullRefreshIndicator indicator,
    FPullRefreshController controller,
  ) : super(
          indicator,
          controller,
        );

  @override
  double getIndicatorSize() {
    final Size size = _getIndicatorRealSize();
    if (size != null) {
      return size.height;
    }
    return 0.0;
  }
}

class TopDirectionHelper extends _VerticalHelper {
  TopDirectionHelper(
    FPullRefreshIndicator indicator,
    FPullRefreshController controller,
  ) : super(
          indicator,
          controller,
        );

  @override
  double getIndicatorOffset(double offset) {
    return -getIndicatorSize() + offset;
  }
}

class BottomDirectionHelper extends _VerticalHelper {
  BottomDirectionHelper(
    FPullRefreshIndicator indicator,
    FPullRefreshController controller,
  ) : super(
          indicator,
          controller,
        );

  @override
  double getIndicatorOffset(double offset) {
    return getIndicatorSize() + offset;
  }
}

class _IndicatorWrapper extends StatefulWidget {
  final WidgetBuilder builder;

  _IndicatorWrapper({
    Key key,
    this.builder,
  })  : assert(builder != null),
        super(key: key);

  @override
  _IndicatorWrapperState createState() => _IndicatorWrapperState();
}

class _IndicatorWrapperState extends State<_IndicatorWrapper> {
  Size get size {
    if (context != null) {
      final RenderObject renderObject = context.findRenderObject();
      if (renderObject is RenderBox) {
        return renderObject.size;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
