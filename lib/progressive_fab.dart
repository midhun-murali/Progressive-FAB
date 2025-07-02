import 'package:flutter/material.dart';

/// A customizable Floating Action Button with a circular progress indicator.
class ProgressiveFAB extends StatelessWidget {
  /// The progress value (0-100) to display on the FAB.
  final double progress; // 0-100
  /// Callback when the FAB is pressed.
  final VoidCallback? onPressed;

  /// The total size (diameter) of the FAB including progress border.
  final double size;

  /// The padding between the FAB and the progress border.
  final double padding;

  /// The background color of the FAB.
  final Color fabColor;

  /// The color of the border (background of progress arc).
  final Color borderColor;

  /// The color of the progress arc.
  final Color progressColor;

  /// The icon to display inside the FAB.
  final Widget icon;

  /// The color of the icon.
  final Color iconColor;

  /// Creates a ProgressiveFAB widget.
  ///
  /// [progress] should be between 0 and 100.
  /// [size] is the total diameter of the widget.
  /// [padding] is the space between the FAB and the progress border.
  /// [fabColor], [borderColor], [progressColor], [icon], and [iconColor] customize appearance.
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

/// Painter for the circular progress and border of the FAB.
class _FabProgressPainter extends CustomPainter {
  /// Progress value (0.0 to 1.0) for the arc.
  final double progress;

  /// Color of the border (background circle).
  final Color borderColor;

  /// Color of the progress arc.
  final Color progressColor;

  /// Creates a painter for the FAB's progress and border.
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

  /// Determines whether the painter should repaint based on property changes.
  @override
  bool shouldRepaint(covariant _FabProgressPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        borderColor != oldDelegate.borderColor ||
        progressColor != oldDelegate.progressColor;
  }
}
