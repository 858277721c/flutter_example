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
              painter: _MyPainter(valueColor: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  static final double allAngle = math.pi * 2;

  final Color valueColor;
  final Color backgroundColor;
  final double strokeWidth;

  final double value;

  _MyPainter({
    this.valueColor,
    Color backgroundColor,
    this.strokeWidth = 2,
    this.value,
  })  : assert(valueColor != null),
        this.backgroundColor = backgroundColor ?? Colors.transparent;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    paint.color = valueColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = strokeWidth;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = math.min(center.dx, center.dy) - strokeWidth / 2;
    if (radius > 0) {
      final Rect rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(rect, allAngle * 3 / 4, allAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(_MyPainter oldDelegate) {
    return valueColor != oldDelegate.valueColor ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
