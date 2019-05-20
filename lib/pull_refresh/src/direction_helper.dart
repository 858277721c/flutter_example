import 'package:flutter/material.dart';

import 'pull_refresh.dart';

abstract class DirectionHelper {
  final GlobalKey<_IndicatorWrapperState> key = GlobalKey();
  final FPullRefreshIndicator indicator;

  DirectionHelper(
    this.indicator,
  ) : assert(indicator != null);

  Size _getIndicatorRealSize() {
    final _IndicatorWrapperState state = key.currentState;
    if (state != null) {
      return state.size;
    }
    return null;
  }

  Widget newWidget(
    BuildContext context,
    FPullRefreshState state,
  ) {
    return _IndicatorWrapper(
      key: key,
      builder: (context) {
        return indicator.build(
          context,
          state,
        );
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

  double getRefreshOffset();
}

abstract class _VerticalHelper extends DirectionHelper {
  _VerticalHelper(FPullRefreshIndicator indicator) : super(indicator);

  @override
  double getIndicatorSize() {
    final Size size = _getIndicatorRealSize();
    if (size != null) {
      return size.height;
    }
    return null;
  }
}

class TopDirectionHelper extends _VerticalHelper {
  TopDirectionHelper(FPullRefreshIndicator indicator) : super(indicator);

  @override
  double getIndicatorOffset(double offset) {
    final double size = getIndicatorSize();
    if (size == null) {
      return -double.infinity;
    }

    return -size + offset;
  }

  @override
  double getRefreshOffset() {
    final double refreshSize = getRefreshSize();
    if (refreshSize != null) {
      return refreshSize;
    }
    return 0.0;
  }
}

class BottomDirectionHelper extends _VerticalHelper {
  BottomDirectionHelper(FPullRefreshIndicator indicator) : super(indicator);

  @override
  double getIndicatorOffset(double offset) {
    final double size = getIndicatorSize();
    if (size == null) {
      return double.infinity;
    }
    return size + offset;
  }

  @override
  double getRefreshOffset() {
    final double refreshSize = getRefreshSize();
    if (refreshSize != null) {
      return -refreshSize;
    }
    return 0.0;
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
    if (mounted) {
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
