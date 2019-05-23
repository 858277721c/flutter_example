import 'dart:math' as math;

import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';

class CustomPainterPage extends StatefulWidget {
  @override
  _CustomPainterPageState createState() => _CustomPainterPageState();
}

class _CustomPainterPageState extends State<CustomPainterPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _controller.addListener(() {
      setState(() {});
    });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double value = _controller.value;

    double sweepValue = _kFirstPartTween.evaluate(_controller);
    double startValue = _kSecondPartTween.evaluate(_controller);

    if (value <= 0.5) {
      final double firstValue = _kFirstPartTween.transform(value);

      sweepValue = _kProgressValueTween.transform(firstValue);
    } else {
      final double secondValue = _kSecondPartTween.transform(value);

      sweepValue = _kProgressValueReverseTween.transform(secondValue);
      startValue = _kProgressValueTween.transform(secondValue);
    }

    print('values----- $sweepValue $startValue');

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
                startValue: startValue,
                sweepValue: sweepValue,
                rotationValue: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final Animatable<double> _kFirstPartTween = CurveTween(
  curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
);

final Animatable<double> _kSecondPartTween = CurveTween(
  curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
);

final Animatable<double> _kProgressValueTween = Tween(begin: 0, end: 0.75);
final Animatable<double> _kProgressValueReverseTween =
    ReverseTween(_kProgressValueTween);

final Animatable<double> _kRotationValueTween = Tween(begin: 0, end: 0.5);

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
    double strokeWidth,
    double startValue,
    double sweepValue,
    double rotationValue,
  })  : this.color = color ?? Colors.transparent,
        this.strokeWidth = strokeWidth ?? 2.0,
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
