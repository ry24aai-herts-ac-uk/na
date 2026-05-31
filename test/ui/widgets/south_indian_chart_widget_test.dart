import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:na/domain/models/south_indian_chart.dart';
import 'package:na/ui/widgets/south_indian_chart_widget.dart';

void main() {
  testWidgets('renders house labels and planet symbols', (tester) async {
    final chart = SouthIndianChart(
      houses: const {
        1: ['Sun', 'Mercury'],
        12: ['Moon'],
      },
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SouthIndianChartWidget(chart: chart)),
      ),
    );

    expect(find.text('H1'), findsOneWidget);
    expect(find.text('H12'), findsOneWidget);
    expect(find.textContaining('☉ Sun'), findsOneWidget);
    expect(find.textContaining('☿ Mercury'), findsOneWidget);
  });
}
