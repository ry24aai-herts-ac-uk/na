import 'package:flutter/material.dart';

import '../../domain/models/south_indian_chart.dart';

class SouthIndianChartWidget extends StatelessWidget {
  const SouthIndianChartWidget({super.key, required this.chart});

  final SouthIndianChart chart;

  static const List<List<int?>> _grid = [
    [12, 1, 2, 3],
    [11, null, null, 4],
    [10, null, null, 5],
    [9, 8, 7, 6],
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
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
    );
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
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: house == null
          ? const SizedBox.shrink()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('H$house', style: theme.textTheme.labelMedium),
                const SizedBox(height: 2),
                Expanded(
                  child: Text(
                    planets.join(', '),
                    style: theme.textTheme.bodySmall,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                  ),
                ),
              ],
            ),
    );
  }
}
