import 'package:flutter/material.dart';

import 'pull_refresh.dart';

abstract class DirectionHelper {
  final GlobalKey<_IndicatorWrapperState> key = GlobalKey();
  final FPullRefreshIndicator indicator;
  final Axis axis;

  DirectionHelper({
    this.indicator,
    this.axis,
  })  : assert(indicator != null),
        assert(axis != null);

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
  double getIndicatorSize() {
    final Size size = _getIndicatorRealSize();
    if (size == null) {
      return null;
    }

    return axis == Axis.vertical ? size.height : size.width;
  }

  /// 指示器可以触发刷新的大小，可能为null
  double getIndicatorReadySize() {
    double size = indicator.getReadySize();
    if (size == null) {
      size = getIndicatorSize();
    }
    return size;
  }

  /// 指示器处于刷新中的大小，可能为null
  double getIndicatorRefreshSize() {
    double size = indicator.getRefreshSize();
    if (size == null) {
      size = getIndicatorSize();
    }
    return size;
  }

  /// 指示器的位置，不为null
  double getIndicatorOffset(double offset);

  /// 刷新状态下刷新控件的位置，可能为null
  double getRefreshWidgetRefreshOffset();

  /// 计算刷新控件的位置
  double computeRefreshWidgetOffset(double offset, double delta);

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

class StartDirectionHelper extends DirectionHelper {
  StartDirectionHelper({
    FPullRefreshIndicator indicator,
    Axis axis,
  }) : super(
          indicator: indicator,
          axis: axis,
        );

  @override
  double getIndicatorOffset(double offset) {
    final double size = getIndicatorSize();
    if (size == null) {
      return -double.infinity;
    }

    return -size + offset;
  }

  @override
  double getRefreshWidgetRefreshOffset() {
    return getIndicatorRefreshSize();
  }

  @override
  double computeRefreshWidgetOffset(double offset, double delta) {
    final double targetOffset = offset + delta;
    return targetOffset < 0 ? 0 : targetOffset;
  }
}

class EndDirectionHelper extends DirectionHelper {
  EndDirectionHelper({
    FPullRefreshIndicator indicator,
    Axis axis,
  }) : super(
          indicator: indicator,
          axis: axis,
        );

  @override
  double getIndicatorOffset(double offset) {
    final double size = getIndicatorSize();
    if (size == null) {
      return double.infinity;
    }
    return size + offset;
  }

  @override
  double getRefreshWidgetRefreshOffset() {
    final double refreshSize = getIndicatorRefreshSize();
    if (refreshSize != null) {
      return -refreshSize;
    }
    return null;
  }

  @override
  double computeRefreshWidgetOffset(double offset, double delta) {
    final double targetOffset = offset + delta;
    return targetOffset > 0 ? 0 : targetOffset;
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
