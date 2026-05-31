class UserProfile {
  const UserProfile({
    required this.id,
    required this.fullName,
    required this.birthDate,
    required this.birthPlace,
  });

  final String id;
  final String fullName;
  final DateTime birthDate;
  final String birthPlace;

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'birth_date': birthDate.toIso8601String(),
        'birth_place': birthPlace,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json['id'] as String,
        fullName: json['full_name'] as String,
        birthDate: DateTime.parse(json['birth_date'] as String),
        birthPlace: json['birth_place'] as String,
      );
}
