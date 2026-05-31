import 'package:flutter/material.dart';

import '../../domain/models/south_indian_chart.dart';
import '../theme/app_design_tokens.dart';

class SouthIndianChartWidget extends StatelessWidget {
  const SouthIndianChartWidget({super.key, required this.chart});

  final SouthIndianChart chart;

  static const List<List<int?>> _grid = [
    [12, 1, 2, 3],
    [11, null, null, 4],
    [10, null, null, 5],
    [9, 8, 7, 6],
  ];

  static const Map<String, String> _planetSymbols = {
    'Sun': '☉',
    'Moon': '☾',
    'Mars': '♂',
    'Mercury': '☿',
    'Jupiter': '♃',
    'Venus': '♀',
    'Saturn': '♄',
    'Rahu': '☊',
    'Ketu': '☋',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.chartBackground,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      padding: const EdgeInsets.all(AppSpacing.xs),
      child: AspectRatio(
        aspectRatio: 1,
        child: Column(
          children: _grid
              .map(
                (row) => Expanded(
                  child: Row(
                    children: row
                        .map(
                          (house) => Expanded(
                            child: _HouseCell(
                              house: house,
                              planets: house == null
                                  ? const []
                                  : chart.planetsForHouse(house),
                            ),
                          ),
                        )
                        .toList(growable: false),
                  ),
                ),
              )
              .toList(growable: false),
        ),
      ),
    );
  }

  static String planetLabel(String planet) {
    final symbol = _planetSymbols[planet] ?? '•';
    return '$symbol $planet';
  }
}

class _HouseCell extends StatelessWidget {
  const _HouseCell({required this.house, required this.planets});

  final int? house;
  final List<String> planets;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(AppSpacing.xxs),
      decoration: BoxDecoration(
        color: AppColors.chartCellBackground,
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: house == null
          ? const SizedBox.shrink()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('H$house', style: theme.textTheme.labelSmall),
                const SizedBox(height: AppSpacing.xxs),
                Expanded(
                  child: Text(
                    planets.map(SouthIndianChartWidget.planetLabel).join('\n'),
                    style: AppTextStyles.compactBody,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                  ),
                ),
              ],
            ),
    );
  }
}
