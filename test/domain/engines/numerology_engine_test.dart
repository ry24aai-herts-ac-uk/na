import 'package:flutter_test/flutter_test.dart';
import 'package:na/domain/engines/numerology_engine.dart';

void main() {
  final engine = NumerologyEngine();

  test('build computes pythagorean and chaldean numbers', () {
    final report = engine.build(
      fullName: 'John Doe',
      birthDate: DateTime(1990, 7, 14),
    );

    expect(report.pythagorean, equals(8));
    expect(report.chaldean, equals(7));
  });

  test('build computes pyramid and prediction', () {
    final report = engine.build(
      fullName: 'Alice',
      birthDate: DateTime(2001, 12, 30),
    );

    expect(report.pyramid, equals([6, 6, 3, 6]));
    expect(report.pyramidPrediction, contains('Creative cycle'));
  });
}
