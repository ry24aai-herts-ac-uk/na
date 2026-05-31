import '../../domain/engines/numerology_engine.dart';
import '../../domain/models/app_settings.dart';
import '../../domain/models/astro_numerology_report.dart';
import '../../domain/models/user_profile.dart';
import '../../domain/services/astrology_api_service.dart';
import '../../domain/services/cloud_database_service.dart';

class ReportRepository {
  const ReportRepository({
    required this.astrologyApi,
    required this.cloudDatabase,
    required this.numerologyEngine,
  });

  final AstrologyApiService astrologyApi;
  final CloudDatabaseService cloudDatabase;
  final NumerologyEngine numerologyEngine;

  Future<AstroNumerologyReport> generateAndStore({
    required UserProfile profile,
    required AppSettings settings,
  }) async {
    final numerology =
        numerologyEngine.build(fullName: profile.fullName, birthDate: profile.birthDate);
    final chart = await astrologyApi.generateSouthIndianChart(
      birthDate: profile.birthDate,
      birthPlace: profile.birthPlace,
    );

    final report = AstroNumerologyReport(
      userId: profile.id,
      createdAt: DateTime.now().toUtc(),
      numerology: numerology,
      chart: chart,
    );

    await cloudDatabase.saveUserProfile(profile);
    await cloudDatabase.saveSettings(settings);
    await cloudDatabase.saveReport(report);

    return report;
  }
}
