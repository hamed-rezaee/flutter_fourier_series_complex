import 'package:flutter/material.dart';
import 'package:flutter_fourier_series/renderer.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double time = 0;
  final List<double> times = [];

  @override
  void initState() {
    super.initState();

    Stream.periodic(const Duration(milliseconds: 16)).listen(
      (_) => setState(
        () {
          times.insert(0, time);
          time += 0.03;

          if (times.length > 300) {
            times.removeLast();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: CustomPaint(
            size: const Size(900, 400),
            painter: Renderer(times: times),
          ),
        ),
      );
}
