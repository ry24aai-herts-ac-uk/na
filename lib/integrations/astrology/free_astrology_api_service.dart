import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/models/south_indian_chart.dart';
import '../../domain/services/astrology_api_service.dart';

class FreeAstrologyApiService implements AstrologyApiService {
  FreeAstrologyApiService({
    required this.baseUrl,
    required this.apiKey,
    http.Client? client,
  }) : _client = client ?? http.Client();

  final String baseUrl;
  final String apiKey;
  final http.Client _client;

  @override
  Future<SouthIndianChart> generateSouthIndianChart({
    required DateTime birthDate,
    required String birthPlace,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/south-indian-chart'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': apiKey,
      },
      body: jsonEncode({
        'birth_date': birthDate.toIso8601String(),
        'birth_place': birthPlace,
      }),
    );

    if (response.statusCode >= 400) {
      throw Exception('Unable to generate chart (${response.statusCode})');
    }

    return SouthIndianChart.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
