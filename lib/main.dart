import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_fourier_series/renderer.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final radius = 100.0;
  final List<double> wave = [];

  double time = 0;
  double x = 0;
  double y = 0;

  @override
  void initState() {
    super.initState();

    Stream.periodic(const Duration(milliseconds: 16)).listen((_) {
      x = radius * math.cos(time);
      y = radius * math.sin(time);
      time += 0.03;

      wave.insert(0, y);

      if (wave.length > 250) {
        wave.removeLast();
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: CustomPaint(
            size: const Size(800, 400),
            painter: Renderer(
              x: x,
              y: y,
              wave: wave,
              radius: radius,
            ),
          ),
        ),
      );
}
