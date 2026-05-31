import '../models/numerology_report.dart';

class NumerologyEngine {
  static const Map<String, int> _chaldean = {
    'A': 1,
    'I': 1,
    'J': 1,
    'Q': 1,
    'Y': 1,
    'B': 2,
    'K': 2,
    'R': 2,
    'C': 3,
    'G': 3,
    'L': 3,
    'S': 3,
    'D': 4,
    'M': 4,
    'T': 4,
    'E': 5,
    'H': 5,
    'N': 5,
    'X': 5,
    'U': 6,
    'V': 6,
    'W': 6,
    'O': 7,
    'Z': 7,
    'F': 8,
    'P': 8,
  };

  static const List<String> _pythagoreanGroups = [
    'AJS',
    'BKT',
    'CLU',
    'DMV',
    'ENW',
    'FOX',
    'GPY',
    'HQZ',
    'IR',
  ];

  NumerologyReport build({required String fullName, required DateTime birthDate}) {
    final cleaned = fullName.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    final pythagorean = _reduce(_sum(cleaned, _pythagoreanValue));
    final chaldean = _reduce(_sum(cleaned, _chaldeanValue));
    final pyramid = _pyramid(birthDate);
    return NumerologyReport(
      pythagorean: pythagorean,
      chaldean: chaldean,
      pyramid: pyramid,
      pyramidPrediction: _predictionFor(pyramid.last),
    );
  }

  int _sum(String text, int Function(String) mapper) {
    var total = 0;
    for (final char in text.split('')) {
      total += mapper(char);
    }
    return total;
  }

  int _pythagoreanValue(String char) {
    for (var i = 0; i < _pythagoreanGroups.length; i++) {
      if (_pythagoreanGroups[i].contains(char)) {
        return i + 1;
      }
    }
    return 0;
  }

  int _chaldeanValue(String char) => _chaldean[char] ?? 0;

  int _reduce(int value) {
    var current = value;
    while (current > 9) {
      var next = 0;
      for (final digit in current.toString().split('')) {
        next += int.parse(digit);
      }
      current = next;
    }
    return current;
  }

  List<int> _pyramid(DateTime birthDate) {
    final day = _reduce(birthDate.day);
    final month = _reduce(birthDate.month);
    final year = _reduce(birthDate.year);

    final first = _reduce(day + month);
    final second = _reduce(day + year);
    final third = _reduce(first + second);
    final fourth = _reduce(month + year);

    return [first, second, third, fourth];
  }

  String _predictionFor(int peak) {
    switch (peak) {
      case 1:
        return 'Leadership-focused cycle with independent growth.';
      case 2:
        return 'Partnership cycle encouraging patience and diplomacy.';
      case 3:
        return 'Creative cycle with communication opportunities.';
      case 4:
        return 'Stability cycle favoring disciplined execution.';
      case 5:
        return 'Change-heavy cycle with travel and flexibility.';
      case 6:
        return 'Responsibility cycle centered on family and care.';
      case 7:
        return 'Reflective cycle for analysis and spiritual insight.';
      case 8:
        return 'Achievement cycle with material progress focus.';
      case 9:
        return 'Completion cycle suited for closure and service.';
      default:
        return 'Neutral cycle with balanced outcomes.';
    }
  }
}
