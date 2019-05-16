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

  Widget newWidget() {
    return _IndicatorWrapper(
      key: key,
      indicator: indicator,
      controller: controller,
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
    final _IndicatorWrapperState state = key.currentState;
    if (state != null) {
      final Size size = state.size;
      if (size != null) {
        return size.height;
      }
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
  final FPullRefreshIndicator indicator;
  final FPullRefreshController controller;

  _IndicatorWrapper({
    Key key,
    this.indicator,
    this.controller,
  })  : assert(indicator != null),
        assert(controller != null),
        super(key: key);

  @override
  _IndicatorWrapperState createState() => _IndicatorWrapperState();
}

class _IndicatorWrapperState extends State<_IndicatorWrapper> {
  Size get size {
    if (context == null) {
      return null;
    }
    return context.size;
  }

  @override
  Widget build(BuildContext context) {
    return widget.indicator.build(widget.controller);
  }
}
