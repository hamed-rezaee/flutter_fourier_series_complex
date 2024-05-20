import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fourier_series/models.dart';

class FourierTransformRenderer extends CustomPainter {
  FourierTransformRenderer({
    required this.time,
    required this.fourier,
    this.waveLength = 250,
  });

  final double time;
  final List<DFTResult> fourier;
  final int waveLength;

  static List<Offset> wave = [];

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..save()
      ..translate(50, 200);

    final position = drwaEpicycles(canvas, 300, 50, 0, fourier);

    wave.insert(0, Offset(position.dx, position.dy) + const Offset(0, 300));

    if (wave.length > waveLength) {
      wave.removeLast();
    }

    canvas
      ..drawPath(
        Path()
          ..moveTo(wave.first.dx, wave.first.dy)
          ..addPolygon(wave, false),
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      )
      ..drawLine(
        Offset(position.dx, position.dy),
        wave.first,
        Paint()
          ..color = Colors.white.withOpacity(0.5)
          ..strokeWidth = 1,
      )
      ..restore();
  }

  Offset epicycles(
    Canvas canvas,
    double x,
    double y,
    double rotation,
    List<DFTResult> fourier,
  ) {
    return Offset.zero;
  }

  Offset drwaEpicycles(
    Canvas canvas,
    double offsetX,
    double offsetY,
    double rotation,
    List<DFTResult> fourier,
  ) {
    var x = offsetX;
    var y = offsetY;

    for (var i = 0; i < fourier.length; i++) {
      final prevX = x;
      final prevY = y;

      final frequency = fourier[i].frequency;
      final amplitude = fourier[i].amplitude;
      final phase = fourier[i].phase;

      x += amplitude * cos(frequency * time + phase + rotation);
      y += amplitude * sin(frequency * time + phase + rotation);

      canvas
        ..drawCircle(
          Offset(prevX, prevY),
          amplitude,
          Paint()
            ..color = Colors.white.withOpacity(0.5)
            ..style = PaintingStyle.stroke,
        )
        ..drawLine(
          Offset(prevX, prevY),
          Offset(x, y),
          Paint()
            ..color = Colors.blue.withOpacity(0.7)
            ..strokeWidth = 2,
        )
        ..drawCircle(
          Offset(prevX, prevY),
          1,
          Paint()..color = Colors.red,
        );
    }

    return Offset(x, y);
  }

  @override
  bool shouldRepaint(FourierTransformRenderer oldDelegate) =>
      oldDelegate.time != time;
}
