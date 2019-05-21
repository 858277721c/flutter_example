import 'package:flutter/material.dart';

import 'pull_refresh.dart';

abstract class DirectionHelper {
  final GlobalKey<_IndicatorWrapperState> key = GlobalKey();
  final FPullRefreshIndicator indicator;

  DirectionHelper(
    this.indicator,
  ) : assert(indicator != null);

  Widget newWidget(BuildIndicatorInfo info) {
    return _IndicatorWrapper(
      key: key,
      builder: (context) {
        final Widget widget = indicator.build(info);
        assert(widget != null);
        return widget;
      },
    );
  }

  Size _getIndicatorRealSize() {
    final _IndicatorWrapperState state = key.currentState;
    if (state != null) {
      return state.size;
    }
    return null;
  }

  bool isReady() {
    return _getIndicatorRealSize() != null;
  }

  /// 指示器的大小，可能为null
  double getIndicatorSize();

  /// 指示器的位置，不为null
  double getIndicatorOffset(double offset);

  /// 指示器可以触发刷新的大小，可能为null
  double getRefreshSize() {
    double size = indicator.getRefreshSize();
    if (size == null) {
      size = getIndicatorSize();
    }
    return size;
  }

  /// 刷新状态下刷新控件的位置，可能为null
  double getRefreshWidgetOffset();

  Duration getAnimationDuration(
    Duration minDuration,
    Duration maxDuration,
    double distance,
  ) {
    return _computeDuration(
      minDuration: minDuration,
      maxDuration: maxDuration,
      distance: distance,
      distanceMax: getIndicatorSize(),
    );
  }

  static _computeDuration({
    Duration minDuration,
    Duration maxDuration,
    double distance,
    double distanceMax,
  }) {
    assert(minDuration != null);
    assert(maxDuration != null);

    if (distance == null || distance == 0) {
      return minDuration;
    }

    if (distanceMax == null || distanceMax == 0) {
      return minDuration;
    }

    distance = distance.abs();
    distanceMax = distanceMax.abs();

    if (distance >= distanceMax) {
      return maxDuration;
    }

    final double disPercent = distance / distanceMax;
    final Duration disDuration = minDuration * disPercent + minDuration;

    return disDuration > maxDuration ? maxDuration : disDuration;
  }
}

abstract class _VerticalHelper extends DirectionHelper {
  _VerticalHelper(FPullRefreshIndicator indicator) : super(indicator);

  @override
  double getIndicatorSize() {
    final Size size = _getIndicatorRealSize();
    if (size == null) {
      return null;
    }

    return size.height;
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
  double getRefreshWidgetOffset() {
    return getRefreshSize();
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
  double getRefreshWidgetOffset() {
    final double refreshSize = getRefreshSize();
    if (refreshSize != null) {
      return -refreshSize;
    }
    return null;
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
