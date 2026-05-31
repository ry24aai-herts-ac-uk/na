import 'package:flutter/material.dart';

import '../theme/app_design_tokens.dart';

class HistoryProfileListItem extends StatelessWidget {
  const HistoryProfileListItem({
    super.key,
    required this.name,
    required this.surname,
    required this.phone,
    required this.dateOfBirth,
    required this.source,
    required this.kind,
  });

  final String name;
  final String surname;
  final String phone;
  final String dateOfBirth;
  final String source;
  final String kind;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        dense: true,
        leading: Icon(
          kind == 'Family' ? Icons.groups : Icons.person,
          size: AppIconSizes.md,
        ),
        title: Text('$name $surname'),
        subtitle: Text('Phone: $phone • DOB: $dateOfBirth'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.xxs,
          ),
          decoration: BoxDecoration(
            color: source == 'Cloud' ? AppColors.infoTint : AppColors.successTint,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Text(source, style: AppTextStyles.label),
        ),
      ),
    );
  }
}
