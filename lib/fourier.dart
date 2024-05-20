import 'dart:math';

import 'package:flutter_fourier_series/models.dart';

class Fourier {
  static List<DFTResult> discreteFourierTransform(
    List<ComplexNumber> input,
  ) {
    final length = input.length;
    final results = <DFTResult>[];

    for (var frequency = 0; frequency < length; frequency++) {
      var sum = const ComplexNumber(real: 0, imaginary: 0);

      for (var i = 0; i < length; i++) {
        final phi = (pi * 2 * frequency * i) / length;
        final exp = ComplexNumber(real: cos(phi), imaginary: -sin(phi));

        sum += input[i] * exp;
      }

      sum = sum.scale(1 / length);

      final amplitude =
          sqrt(sum.real * sum.real + sum.imaginary * sum.imaginary);
      final phase = atan2(sum.imaginary, sum.real);

      results.add(
        DFTResult(
          complex: sum,
          frequency: frequency,
          amplitude: amplitude,
          phase: phase,
        ),
      );
    }

    return results;
  }
}
