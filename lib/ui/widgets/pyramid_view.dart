import 'package:flutter/material.dart';

import '../theme/app_design_tokens.dart';

class PyramidView extends StatelessWidget {
  const PyramidView({super.key, required this.rows});

  final List<List<int>> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: rows
          .map(
            (row) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row
                    .map(
                      (value) => Container(
                        width: 36,
                        height: 36,
                        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Text(
                          '$value',
                          style: AppTextStyles.value,
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}
