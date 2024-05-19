import 'dart:math' as math;

import 'package:flutter/material.dart';

class Renderer extends CustomPainter {
  const Renderer({required this.time});

  final double time;
  final double radius = 100;

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

    final double x = radius * math.cos(time);
    final double y = radius * math.sin(time);

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), blackPainter);

    canvas.save();
    canvas.translate(200, 200);
    canvas.drawCircle(Offset.zero, radius, whitePaint);
    canvas.drawCircle(Offset(x, y), 8, whitePaint..style = PaintingStyle.fill);
    canvas.drawLine(Offset.zero, Offset(x, y), whitePaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
