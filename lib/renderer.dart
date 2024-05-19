import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class Renderer extends CustomPainter {
  const Renderer({
    required this.times,
    this.sinWavesCount = 5,
  });

  final List<double> times;
  final double sinWavesCount;

  static List<double> wave = [];

  @override
  void paint(Canvas canvas, Size size) {
    double x = 0;
    double y = 0;
    double radius = 0;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.black,
    );

    if (times.isEmpty) {
      return;
    }

    canvas.save();
    canvas.translate(100, 200);

    for (var i = 0; i < sinWavesCount; i++) {
      final prevX = x;
      final prevY = y;
      final n = i * 2 + 1;

      radius = 100 * (4 / (math.pi * n));

      x += radius * math.cos(n * times.first);
      y += radius * math.sin(n * times.first);

      canvas.drawCircle(
        Offset(prevX + 200, prevY),
        radius,
        Paint()
          ..color = Colors.white.withOpacity(0.4)
          ..style = PaintingStyle.stroke,
      );

      canvas.drawLine(
        Offset(prevX + 200, prevY),
        Offset(x + 200, y),
        Paint()..color = Colors.blue.withOpacity(0.7),
      );

      canvas.drawCircle(
        Offset(prevX + 200, prevY),
        2,
        Paint()..color = Colors.red,
      );
    }

    wave.insert(0, y);

    if (wave.length > 250) {
      wave.removeLast();
    }

    canvas.drawPoints(
      PointMode.polygon,
      wave
          .asMap()
          .entries
          .map((point) => Offset(point.key + 450, point.value))
          .toList(),
      Paint()
        ..color = Colors.red
        ..strokeWidth = 2,
    );

    canvas.drawLine(
      Offset(x + 200, y),
      Offset(450, wave.first),
      Paint()
        ..color = Colors.green
        ..strokeWidth = 2,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
