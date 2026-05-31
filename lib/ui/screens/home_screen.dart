import 'package:flutter/material.dart';

import '../../domain/engines/numerology_engine.dart';
import '../../domain/models/south_indian_chart.dart';
import '../widgets/south_indian_chart_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _nameController = TextEditingController();
  final _birthDateController = TextEditingController(text: '1995-01-01');
  final _engine = NumerologyEngine();

  String? _result;

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chart = SouthIndianChart(
      houses: const {
        1: ['Sun'],
        4: ['Moon'],
        7: ['Mars'],
        10: ['Jupiter'],
      },
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Astrology & Numerology')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Full name'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _birthDateController,
            decoration: const InputDecoration(labelText: 'Birth date (YYYY-MM-DD)'),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: _calculate,
            child: const Text('Generate local numerology'),
          ),
          if (_result != null) ...[
            const SizedBox(height: 12),
            Text(_result!),
          ],
          const SizedBox(height: 20),
          const Text('South Indian chart preview'),
          const SizedBox(height: 8),
          SouthIndianChartWidget(chart: chart),
        ],
      ),
    );
  }

  void _calculate() {
    final date = DateTime.tryParse(_birthDateController.text);
    if (date == null || _nameController.text.trim().isEmpty) {
      setState(() {
        _result = 'Enter a valid name and birth date.';
      });
      return;
    }

    final report = _engine.build(fullName: _nameController.text, birthDate: date);
    setState(() {
      _result =
          'Pythagorean: ${report.pythagorean}, Chaldean: ${report.chaldean}, Pyramid: ${report.pyramid.join('-')}';
    });
  }
}
