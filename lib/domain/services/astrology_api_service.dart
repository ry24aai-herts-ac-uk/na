import '../models/south_indian_chart.dart';

abstract interface class AstrologyApiService {
  Future<SouthIndianChart> generateSouthIndianChart({
    required DateTime birthDate,
    required String birthPlace,
  });
}
