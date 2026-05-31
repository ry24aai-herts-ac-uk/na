import 'package:flutter/material.dart';

import '../theme/app_design_tokens.dart';

class LuckyUnluckyPanel extends StatelessWidget {
  const LuckyUnluckyPanel({
    super.key,
    required this.lucky,
    required this.unlucky,
    required this.destiny,
  });

  final List<int> lucky;
  final List<int> unlucky;
  final int destiny;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TagBucket(
            title: 'Lucky',
            numbers: lucky,
            color: AppColors.successTint,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _TagBucket(
            title: 'Unlucky',
            numbers: unlucky,
            color: AppColors.warningTint,
            subtitle: 'Destiny: $destiny',
          ),
        ),
      ],
    );
  }
}

class _TagBucket extends StatelessWidget {
  const _TagBucket({
    required this.title,
    required this.numbers,
    required this.color,
    this.subtitle,
  });

  final String title;
  final List<int> numbers;
  final Color color;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.label),
          if (subtitle != null)
            Text(subtitle!, style: theme.textTheme.bodySmall),
          const SizedBox(height: AppSpacing.xxs),
          Wrap(
            spacing: AppSpacing.xxs,
            runSpacing: AppSpacing.xxs,
            children: numbers
                .map(
                  (number) => Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text('$number', style: AppTextStyles.label),
                  ),
                )
                .toList(growable: false),
          ),
        ],
      ),
    );
  }
}
