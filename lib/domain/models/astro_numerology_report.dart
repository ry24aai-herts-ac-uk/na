import 'numerology_report.dart';
import 'south_indian_chart.dart';

class AstroNumerologyReport {
  const AstroNumerologyReport({
    required this.userId,
    required this.createdAt,
    required this.numerology,
    required this.chart,
  });

  final String userId;
  final DateTime createdAt;
  final NumerologyReport numerology;
  final SouthIndianChart chart;

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'created_at': createdAt.toIso8601String(),
        'numerology': numerology.toJson(),
        'chart': chart.toJson(),
      };
}
