import 'package:flutter/material.dart';

class ComplexNumber {
  const ComplexNumber({required this.real, required this.imaginary});

  final double real;
  final double imaginary;

  ComplexNumber operator +(ComplexNumber other) => ComplexNumber(
        real: real + other.real,
        imaginary: imaginary + other.imaginary,
      );

  ComplexNumber operator *(ComplexNumber other) => ComplexNumber(
        real: real * other.real - imaginary * other.imaginary,
        imaginary: real * other.imaginary + imaginary * other.real,
      );

  ComplexNumber scale(double scalar) => ComplexNumber(
        real: real * scalar,
        imaginary: imaginary * scalar,
      );

  Offset toOffset() => Offset(real, imaginary);
}

class DFTResult {
  const DFTResult({
    required this.complex,
    required this.frequency,
    required this.amplitude,
    required this.phase,
  });

  final ComplexNumber complex;
  final int frequency;
  final double amplitude;
  final double phase;
}
