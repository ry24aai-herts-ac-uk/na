import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/models/app_settings.dart';
import '../../domain/models/astro_numerology_report.dart';
import '../../domain/models/user_profile.dart';
import '../../domain/services/cloud_database_service.dart';

class FreeCloudDatabaseService implements CloudDatabaseService {
  FreeCloudDatabaseService({
    required this.baseUrl,
    required this.apiKey,
    http.Client? client,
  }) : _client = client ?? http.Client();

  final String baseUrl;
  final String apiKey;
  final http.Client _client;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'apikey': apiKey,
        'x-api-key': apiKey,
      };

  @override
  Future<void> saveUserProfile(UserProfile profile) =>
      _upsert('profiles', profile.toJson());

  @override
  Future<void> saveSettings(AppSettings settings) =>
      _upsert('settings', settings.toJson());

  @override
  Future<void> saveReport(AstroNumerologyReport report) =>
      _upsert('reports', report.toJson());

  @override
  Future<UserProfile?> fetchUserProfile(String userId) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/rest/v1/profiles?id=eq.$userId&select=*'),
      headers: _headers,
    );

    if (response.statusCode >= 400) {
      throw Exception('Unable to fetch profile (${response.statusCode})');
    }

    final list = jsonDecode(response.body) as List<dynamic>;
    if (list.isEmpty) {
      return null;
    }

    return UserProfile.fromJson(list.first as Map<String, dynamic>);
  }

  Future<void> _upsert(String table, Map<String, dynamic> payload) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/rest/v1/$table'),
      headers: {
        ..._headers,
        'Prefer': 'resolution=merge-duplicates,return=minimal',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode >= 400) {
      throw Exception('Unable to save $table (${response.statusCode})');
    }
  }
}
