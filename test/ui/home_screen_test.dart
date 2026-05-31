import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:na/ui/screens/home_screen.dart';

void main() {
  testWidgets('renders top-level tabs', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: HomeScreen()),
    );

    expect(find.text('Calculator'), findsOneWidget);
    expect(find.text('Naming'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
  });
}
