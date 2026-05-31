import 'package:flutter/material.dart';

import '../theme/app_design_tokens.dart';

class NumerologyResultRow {
  const NumerologyResultRow({
    required this.label,
    required this.total,
    required this.reduced,
  });

  final String label;
  final int total;
  final int reduced;
}

class NumerologyResultTable extends StatelessWidget {
  const NumerologyResultTable({
    super.key,
    required this.title,
    required this.rows,
  });

  final String title;
  final List<NumerologyResultRow> rows;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.xs),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(2.6),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Text('Combination', style: theme.textTheme.labelMedium),
                Text('Total', style: theme.textTheme.labelMedium),
                Text('Final', style: theme.textTheme.labelMedium),
              ],
            ),
            ...rows.map(
              (row) => TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
                    child: Text(row.label),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
                    child: Text('${row.total}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
                    child: Text('${row.reduced}'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
