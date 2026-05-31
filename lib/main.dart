import 'package:flutter/material.dart';

import 'ui/screens/home_screen.dart';

void main() {
  runApp(const AstrologyNumerologyApp());
}

class AstrologyNumerologyApp extends StatelessWidget {
  const AstrologyNumerologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astrology & Numerology',
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
