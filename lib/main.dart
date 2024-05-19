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

  @override
  void initState() {
    super.initState();

    Stream.periodic(const Duration(milliseconds: 16))
        .listen((_) => setState(() => time -= 0.05));
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: CustomPaint(
            size: const Size(600, 400),
            painter: Renderer(time: time),
          ),
        ),
      );
}
