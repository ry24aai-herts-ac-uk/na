import '../models/app_settings.dart';
import '../models/astro_numerology_report.dart';
import '../models/user_profile.dart';

abstract interface class CloudDatabaseService {
  Future<void> saveUserProfile(UserProfile profile);

  Future<void> saveSettings(AppSettings settings);

  Future<void> saveReport(AstroNumerologyReport report);

  Future<UserProfile?> fetchUserProfile(String userId);
}
