import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class Renderer extends CustomPainter {
  const Renderer({
    required this.time,
    this.sinWavesCount = 6,
    this.waveLength = 250,
  });

  final double time;
  final double sinWavesCount;
  final int waveLength;

  static List<double> wave = [];

  @override
  void paint(Canvas canvas, Size size) {
    var x = 0.0;
    var y = 0.0;
    var radius = 0.0;

    canvas
      ..drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.black,
      )
      ..save()
      ..translate(100, 200);

    for (var i = 0; i < sinWavesCount; i++) {
      final n = i * 2 + 1;

      final prevX = x;
      final prevY = y;

      radius = 100 * (4 / (math.pi * n));

      x += radius * math.cos(n * time);
      y += radius * math.sin(n * time);

      canvas
        ..drawCircle(
          Offset(prevX + 200, prevY),
          radius,
          Paint()
            ..color = Colors.white.withOpacity(0.4)
            ..style = PaintingStyle.stroke,
        )
        ..drawLine(
          Offset(prevX + 200, prevY),
          Offset(x + 200, y),
          Paint()..color = Colors.blue.withOpacity(0.7),
        )
        ..drawCircle(
          Offset(prevX + 200, prevY),
          2,
          Paint()..color = Colors.red,
        );
    }

    wave.insert(0, y);

    if (wave.length > waveLength) {
      wave.removeLast();
    }

    canvas
      ..drawPoints(
        PointMode.polygon,
        wave
            .asMap()
            .entries
            .map((point) => Offset(point.key + 450, point.value))
            .toList(),
        Paint()
          ..color = Colors.red
          ..strokeWidth = 2,
      )
      ..drawLine(
        Offset(x + 200, y),
        Offset(450, wave.first),
        Paint()
          ..color = Colors.green
          ..strokeWidth = 2,
      )
      ..restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
