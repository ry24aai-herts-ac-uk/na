class AppSettings {
  const AppSettings({
    required this.userId,
    required this.timezone,
    required this.preferredLanguage,
  });

  final String userId;
  final String timezone;
  final String preferredLanguage;

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'timezone': timezone,
        'preferred_language': preferredLanguage,
      };

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
        userId: json['user_id'] as String,
        timezone: json['timezone'] as String,
        preferredLanguage: json['preferred_language'] as String,
      );
}
