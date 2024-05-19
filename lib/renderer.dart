import 'dart:ui';

import 'package:flutter/material.dart';

class Renderer extends CustomPainter {
  const Renderer({
    required this.x,
    required this.y,
    required this.wave,
    required this.radius,
  });

  final double x;
  final double y;
  final List<double> wave;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final whitePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final blackPainter = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    final redColor = Paint()
      ..color = Colors.red
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), blackPainter);

    canvas.save();
    canvas.translate(200, 200);
    canvas.drawCircle(Offset.zero, radius, whitePaint);
    canvas.drawLine(Offset.zero, Offset(x, y), whitePaint);
    canvas.drawLine(Offset(x, y), Offset(200, y), redColor);
    canvas.drawCircle(Offset(x, y), 4, whitePaint..style = PaintingStyle.fill);

    canvas.drawPoints(
      PointMode.polygon,
      wave
          .asMap()
          .entries
          .map((point) => Offset(point.key.toDouble() + 200, point.value))
          .toList(),
      whitePaint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
