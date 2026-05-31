import 'package:flutter/material.dart';

import '../theme/app_design_tokens.dart';

class NumberMappingRow extends StatelessWidget {
  const NumberMappingRow({
    super.key,
    required this.label,
    required this.characters,
    required this.numbers,
    required this.total,
    required this.reduced,
  });

  final String label;
  final String characters;
  final List<int> numbers;
  final int total;
  final int reduced;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final letters = characters.split('');

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.label),
          const SizedBox(height: AppSpacing.xxs),
          Wrap(
            spacing: AppSpacing.xxs,
            runSpacing: AppSpacing.xxs,
            children: List.generate(
              letters.length,
              (index) => Chip(
                visualDensity: VisualDensity.compact,
                labelPadding: EdgeInsets.zero,
                label: Text('${letters[index]}:${numbers[index]}'),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            'Total: $total  →  Reduced: $reduced',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
