import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fourier_series/fourier.dart';
import 'package:flutter_fourier_series/fourier_transform_renderer.dart';
import 'package:flutter_fourier_series/models.dart';
import 'package:flutter_fourier_series/sample.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final List<DFTResult> fourier;

  double time = 0;

  @override
  void initState() {
    super.initState();

    fourier = Fourier.discreteFourierTransform(
      flutterLogo
          .map(
            (point) =>
                ComplexNumber(real: point.dx / 5, imaginary: point.dy / 5),
          )
          .toList(),
    )..sort((a, b) => b.amplitude.compareTo(a.amplitude));

    Stream<void>.periodic(const Duration(milliseconds: 32)).listen(
      (_) => setState(() => time += (pi * 2) / flutterLogo.length),
    );
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: CustomPaint(
            size: const Size(900, 400),
            // painter: FourierSeriesRenderer(time: time),
            painter: FourierTransformRenderer(
              time: time,
              fourier: fourier,
              waveLength: flutterLogo.length,
            ),
          ),
        ),
      );
}
