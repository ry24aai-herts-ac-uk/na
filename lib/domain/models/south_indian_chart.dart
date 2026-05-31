class SouthIndianChart {
  const SouthIndianChart({required this.houses});

  final Map<int, List<String>> houses;

  List<String> planetsForHouse(int house) => houses[house] ?? const [];

  Map<String, dynamic> toJson() => {
        'houses': houses.map((key, value) => MapEntry('$key', value)),
      };

  factory SouthIndianChart.fromJson(Map<String, dynamic> json) {
    final raw = (json['houses'] as Map<String, dynamic>?) ?? {};
    return SouthIndianChart(
      houses: raw.map(
        (key, value) => MapEntry(
          int.parse(key),
          List<String>.from(value as List<dynamic>),
        ),
      ),
    );
  }
}
