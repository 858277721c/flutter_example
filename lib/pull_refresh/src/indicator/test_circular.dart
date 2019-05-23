import 'package:flutter/material.dart';
import 'dart:math' as math;

class TestCircularProgressIndicator extends ProgressIndicator {
  /// Creates a circular progress indicator.
  ///
  /// {@macro flutter.material.progressIndicator.parameters}
  const TestCircularProgressIndicator({
    Key key,
    double value,
    Color backgroundColor,
    Animation<Color> valueColor,
    this.strokeWidth = 4.0,
    String semanticsLabel,
    String semanticsValue,
  }) : super(
    key: key,
    value: value,
    backgroundColor: backgroundColor,
    valueColor: valueColor,
    semanticsLabel: semanticsLabel,
    semanticsValue: semanticsValue,
  );

  /// The width of the line used to draw the circle.
  final double strokeWidth;

  @override
  _CircularProgressIndicatorState createState() => _CircularProgressIndicatorState();
}

// Tweens used by circular progress indicator
final Animatable<double> _kStrokeHeadTween = CurveTween(
  curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
).chain(CurveTween(
  curve: const SawTooth(5),
));

final Animatable<double> _kStrokeTailTween = CurveTween(
  curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
).chain(CurveTween(
  curve: const SawTooth(5),
));

final Animatable<int> _kStepTween = StepTween(begin: 0, end: 5);

final Animatable<double> _kRotationTween = CurveTween(curve: const SawTooth(5));

class _CircularProgressIndicatorState extends State<TestCircularProgressIndicator> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    if (widget.value == null)
      _controller.repeat();
  }

  @override
  void didUpdateWidget(TestCircularProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && !_controller.isAnimating)
      _controller.repeat();
    else if (widget.value != null && _controller.isAnimating)
      _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildIndicator(BuildContext context, double headValue, double tailValue, int stepValue, double rotationValue) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 30,
        minHeight: 30,
      ),
      child: CustomPaint(
        painter: _CircularProgressIndicatorPainter(
          backgroundColor: widget.backgroundColor,
          valueColor: Colors.red,
          value: widget.value, // may be null
          headValue: headValue, // remaining arguments are ignored if widget.value is not null
          tailValue: tailValue,
          stepValue: stepValue,
          rotationValue: rotationValue,
          strokeWidth: widget.strokeWidth,
        ),
      ),
    );
  }

  Widget _buildAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return _buildIndicator(
          context,
          _kStrokeHeadTween.evaluate(_controller),
          _kStrokeTailTween.evaluate(_controller),
          _kStepTween.evaluate(_controller),
          _kRotationTween.evaluate(_controller),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value != null)
      return _buildIndicator(context, 0.0, 0.0, 0, 0.0);
    return _buildAnimation();
  }
}

class _CircularProgressIndicatorPainter extends CustomPainter {
  _CircularProgressIndicatorPainter({
    this.backgroundColor,
    this.valueColor,
    this.value,
    this.headValue,
    this.tailValue,
    this.stepValue,
    this.rotationValue,
    this.strokeWidth,
  }) : arcStart = value != null
      ? _startAngle
      : _startAngle + tailValue * 3 / 2 * math.pi + rotationValue * math.pi * 1.7 - stepValue * 0.8 * math.pi,
        arcSweep = value != null
            ? value.clamp(0.0, 1.0) * _sweep
            : math.max(headValue * 3 / 2 * math.pi - tailValue * 3 / 2 * math.pi, _epsilon);

  final Color backgroundColor;
  final Color valueColor;
  final double value;
  final double headValue;
  final double tailValue;
  final int stepValue;
  final double rotationValue;
  final double strokeWidth;
  final double arcStart;
  final double arcSweep;

  static const double _twoPi = math.pi * 2.0;
  static const double _epsilon = .001;
  // Canvas.drawArc(r, 0, 2*PI) doesn't draw anything, so just get close.
  static const double _sweep = _twoPi - _epsilon;
  static const double _startAngle = -math.pi / 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = valueColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    if (backgroundColor != null) {
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(Offset.zero & size, 0, _sweep, false, backgroundPaint);
    }

    if (value == null) // Indeterminate
      paint.strokeCap = StrokeCap.square;

    canvas.drawArc(Offset.zero & size, arcStart, arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(_CircularProgressIndicatorPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor
        || oldPainter.valueColor != valueColor
        || oldPainter.value != value
        || oldPainter.headValue != headValue
        || oldPainter.tailValue != tailValue
        || oldPainter.stepValue != stepValue
        || oldPainter.rotationValue != rotationValue
        || oldPainter.strokeWidth != strokeWidth;
  }
}