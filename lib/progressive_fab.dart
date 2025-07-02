import 'package:flutter/material.dart';

class ProgressiveFAB extends StatelessWidget {
  final double progress; // 0-100
  final VoidCallback? onPressed;
  final double size;
  final double padding;
  final Color fabColor;
  final Color borderColor;
  final Color progressColor;
  final Widget icon;
  final Color iconColor;

  const ProgressiveFAB({
    super.key,
    required this.progress,
    this.onPressed,
    this.size = 100,
    this.padding = 15,
    this.fabColor = Colors.blue,
    this.borderColor = Colors.grey,
    this.progressColor = Colors.blue,
    this.icon = const Icon(Icons.check),
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final double fabSize = size - 2 * padding;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _FabProgressPainter(
              progress: progress / 100,
              borderColor: borderColor,
              progressColor: progressColor,
            ),
          ),
          RawMaterialButton(
            onPressed: onPressed,
            elevation: 6.0,
            fillColor: fabColor,
            shape: const CircleBorder(),
            constraints: BoxConstraints.tightFor(
              width: fabSize,
              height: fabSize,
            ),
            child: IconTheme(
              data: IconThemeData(color: iconColor),
              child: icon,
            ),
          ),
        ],
      ),
    );
  }
}

class _FabProgressPainter extends CustomPainter {
  final double progress; // 0.0 to 1.0
  final Color borderColor;
  final Color progressColor;

  _FabProgressPainter({
    required this.progress,
    required this.borderColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const double strokeWidth = 5;
    final radius = (size.width / 2) - strokeWidth / 2;

    // Draw border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, borderPaint);

    // Draw progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    double sweepAngle = 2 * 3.141592653589793 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _FabProgressPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        borderColor != oldDelegate.borderColor ||
        progressColor != oldDelegate.progressColor;
  }
}