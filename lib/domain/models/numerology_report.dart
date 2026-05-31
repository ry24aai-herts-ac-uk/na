class NumerologyReport {
  const NumerologyReport({
    required this.pythagorean,
    required this.chaldean,
    required this.pyramid,
    required this.pyramidPrediction,
  });

  final int pythagorean;
  final int chaldean;
  final List<int> pyramid;
  final String pyramidPrediction;

  Map<String, dynamic> toJson() => {
        'pythagorean': pythagorean,
        'chaldean': chaldean,
        'pyramid': pyramid,
        'pyramid_prediction': pyramidPrediction,
      };
}
