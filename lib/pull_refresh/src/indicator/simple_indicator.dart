import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:my_flutter/pull_refresh/src/pull_refresh.dart';

class FSimpleCircularRefreshIndicator extends FPullRefreshIndicator {
  @override
  Widget build(BuildIndicatorInfo info) {
    final double readyPercent = info.readyPercent();

    double value;
    switch (info.state) {
      case FPullRefreshState.pullStart:
      case FPullRefreshState.pullReady:
        value = readyPercent;
        break;
      case FPullRefreshState.refresh:
        if (info.offset.abs() == info.refreshSize) {
          value = null;
        } else {
          value = 1;
        }
        break;
      case FPullRefreshState.idle:
      case FPullRefreshState.refreshResult:
      case FPullRefreshState.finish:
        value = 0;
        break;
    }

    Widget widgetProgress = CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      strokeWidth: 2,
      value: value,
    );

    double angle = 0;

    if (info.axis == Axis.vertical) {
      if (info.direction == FPullRefreshDirection.end) {
        angle = math.pi;
      }
    } else {
      if (info.direction == FPullRefreshDirection.start) {
        angle = math.pi * 1.5;
      } else if (info.direction == FPullRefreshDirection.end) {
        angle = math.pi * (0.5);
      }
    }

    if (angle != 0) {
      widgetProgress = Transform.rotate(
        angle: angle,
        child: widgetProgress,
      );
    }

    return Container(
      width: info.axis == Axis.horizontal ? 40 : null,
      height: info.axis == Axis.vertical ? 40 : null,
      alignment: Alignment.center,
      child: SizedBox(
        width: 25,
        height: 25,
        child: widgetProgress,
      ),
    );
  }

  @override
  double getReadySize() {
    return 50;
  }
}
