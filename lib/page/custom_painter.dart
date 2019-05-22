import 'dart:math' as math;

import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';

class CustomPainterPage extends StatefulWidget {
  @override
  _CustomPainterPageState createState() => _CustomPainterPageState();
}

class _CustomPainterPageState extends State<CustomPainterPage> {
  @override
  Widget build(BuildContext context) {
    return FSafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.runtimeType.toString()),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Container(
            color: Colors.blue,
            width: 100,
            height: 100,
            child: CustomPaint(
              painter: _FCircularProgressIndicatorPainter(
                color: Colors.red,
                backgroundColor: Colors.black26,
                startValue: 0.0,
                sweepValue: 0.5,
                rotationValue: 0.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FCircularProgressIndicatorPainter extends CustomPainter {
  static final double angleAll = math.pi * 2;

  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  final double startValue;
  final double sweepValue;
  final double rotationValue;

  double _arcStart;
  double _arcSweep;

  _FCircularProgressIndicatorPainter({
    Color color,
    this.backgroundColor,
    this.strokeWidth = 2,
    double startValue,
    double sweepValue,
    double rotationValue,
  })  : this.color = color ?? Colors.transparent,
        this.startValue = startValue == null ? 0.0 : startValue.clamp(0.0, 1.0),
        this.sweepValue = sweepValue == null ? 0.0 : sweepValue.clamp(0.0, 1.0),
        this.rotationValue =
            rotationValue == null ? 0.0 : rotationValue.clamp(0.0, 1.0) {
    _arcStart = angleAll * this.startValue + angleAll * this.rotationValue;
    _arcSweep = angleAll * this.sweepValue;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = math.min(center.dx, center.dy) - strokeWidth / 2;
    if (radius <= 0) {
      return;
    }

    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    final Paint paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = strokeWidth;
    paint.strokeCap = StrokeCap.square;

    if (backgroundColor != null) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, 0, angleAll, false, paint);
    }

    paint.color = color;
    canvas.drawArc(rect, _arcStart, _arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(_FCircularProgressIndicatorPainter oldDelegate) {
    return color != oldDelegate.color ||
        backgroundColor != oldDelegate.backgroundColor ||
        strokeWidth != oldDelegate.strokeWidth ||
        startValue != oldDelegate.startValue ||
        sweepValue != oldDelegate.sweepValue ||
        rotationValue != oldDelegate.rotationValue;
  }
}
