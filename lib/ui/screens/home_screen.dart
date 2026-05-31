import 'package:flutter/material.dart';

import '../../domain/engines/numerology_engine.dart';
import '../../domain/models/numerology_report.dart';
import '../../domain/models/south_indian_chart.dart';
import '../theme/app_design_tokens.dart';
import '../widgets/history_profile_list_item.dart';
import '../widgets/info_card.dart';
import '../widgets/lucky_unlucky_panel.dart';
import '../widgets/number_mapping_row.dart';
import '../widgets/numerology_result_table.dart';
import '../widgets/pyramid_view.dart';
import '../widgets/south_indian_chart_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _nameController = TextEditingController();
  final _birthDateController = TextEditingController(text: '1995-01-01');
  final _historySearchController = TextEditingController();
  final _lettersControllers =
      List.generate(6, (_) => TextEditingController(), growable: false);
  final _engine = NumerologyEngine();

  _NamingTarget _namingTarget = _NamingTarget.person;
  int _suggestionCount = 5;
  String? _selectedSuggestion;

  static const _localNamePool = [
    'Aarav',
    'Anaya',
    'Bhavya',
    'Devansh',
    'Eshan',
    'Ira',
    'Kiran',
    'Lakshya',
    'Mira',
    'Nivaan',
    'Omkar',
    'Riya',
    'Saanvi',
    'Tara',
    'Vihaan',
  ];

  static const _cloudNamePool = [
    'Aster Labs',
    'Blue Orbit',
    'Crestline',
    'DeltaNova',
    'EchoEdge',
    'FirstLight',
    'Golden Arc',
    'Halo Dynamics',
    'IonBridge',
    'Zenith Works',
  ];

  static const _historyRecords = [
    _HistoryRecord('Arun', 'Kumar', '9876543210', '1990-08-04', 'Local', 'Family'),
    _HistoryRecord('Meera', 'Shah', '9123456780', '1988-02-14', 'Cloud', 'Person'),
    _HistoryRecord('Rahul', 'Patel', '9988776655', '1995-01-01', 'Cloud', 'Family'),
    _HistoryRecord('Sneha', 'Iyer', '9012345678', '1992-11-23', 'Local', 'Person'),
  ];

  static const _pythagoreanGroups = [
    'AJS',
    'BKT',
    'CLU',
    'DMV',
    'ENW',
    'FOX',
    'GPY',
    'HQZ',
    'IR',
  ];

  static const _chaldeanMap = {
    'A': 1,
    'I': 1,
    'J': 1,
    'Q': 1,
    'Y': 1,
    'B': 2,
    'K': 2,
    'R': 2,
    'C': 3,
    'G': 3,
    'L': 3,
    'S': 3,
    'D': 4,
    'M': 4,
    'T': 4,
    'E': 5,
    'H': 5,
    'N': 5,
    'X': 5,
    'U': 6,
    'V': 6,
    'W': 6,
    'O': 7,
    'Z': 7,
    'F': 8,
    'P': 8,
  };

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_refresh);
    _birthDateController.addListener(_refresh);
    _historySearchController.addListener(_refresh);
    for (final controller in _lettersControllers) {
      controller.addListener(_refresh);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _historySearchController.dispose();
    for (final controller in _lettersControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Astro Numero'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Calculator'),
              Tab(text: 'Naming'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCalculatorTab(),
            _buildNamingTab(),
            _buildHistoryTab(),
          ],
        ),
      ),
    );
  }

  void _refresh() {
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  NumerologyReport? _buildReport() {
    final date = DateTime.tryParse(_birthDateController.text);
    final name = _nameController.text.trim();
    if (date == null || name.isEmpty) {
      return null;
    }
    return _engine.build(fullName: name, birthDate: date);
  }

  List<String> _nameParts() {
    return _nameController.text
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList(growable: false);
  }

  Widget _buildCalculatorTab() {
    final report = _buildReport();
    final chart = SouthIndianChart(
      houses: const {
        1: ['Sun'],
        4: ['Moon'],
        7: ['Mars'],
        10: ['Jupiter'],
      },
    );

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Full name'),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _birthDateController,
          decoration: const InputDecoration(labelText: 'Birth date (YYYY-MM-DD)'),
        ),
        const SizedBox(height: AppSpacing.sm),
        DefaultTabController(
          length: 3,
          child: Column(
            children: [
              SizedBox(
                height: AppTabSizes.height,
                child: TabBar(
                  dividerHeight: 0,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: AppTabSizes.indicatorPadding,
                  tabs: const [
                    Tab(text: 'Astrology chart'),
                    Tab(text: 'Pythagorean + Chaldean'),
                    Tab(text: 'Pyramid numerology'),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: 520,
                child: TabBarView(
                  children: [
                    _buildAstrologySection(chart),
                    _buildNumerologySection(report),
                    _buildPyramidSection(report),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAstrologySection(SouthIndianChart chart) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth > 700 ? 320.0 : 260.0;
        return Center(
          child: SizedBox(
            width: size,
            child: InfoCard(
              title: 'South Indian chart',
              child: SouthIndianChartWidget(chart: chart),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNumerologySection(NumerologyReport? report) {
    if (report == null) {
      return const Center(child: Text('Enter name and valid birth date.'));
    }

    final combinations = _buildCombinations();
    final pythRows = combinations
        .map((entry) => _buildMappedValue(entry.$1, entry.$2, _pythagoreanValue))
        .toList(growable: false);
    final chaldeanRows = combinations
        .map((entry) => _buildMappedValue(entry.$1, entry.$2, _chaldeanValue))
        .toList(growable: false);
    final pythSummary = pythRows
        .map(
          (row) => NumerologyResultRow(
            label: row.label,
            total: row.total,
            reduced: row.reduced,
          ),
        )
        .toList(growable: false);
    final chaldeanSummary = chaldeanRows
        .map(
          (row) => NumerologyResultRow(
            label: row.label,
            total: row.total,
            reduced: row.reduced,
          ),
        )
        .toList(growable: false);

    final destiny = _reduce(
      _birthDateController.text
          .replaceAll('-', '')
          .split('')
          .where((digit) => RegExp(r'\d').hasMatch(digit))
          .map(int.parse)
          .fold<int>(0, (sum, value) => sum + value),
    );

    final lucky = <int>{report.pythagorean, report.chaldean, destiny}.toList()
      ..sort();
    final unlucky = List.generate(9, (i) => i + 1)
        .where((n) => !lucky.contains(n))
        .take(4)
        .toList(growable: false);

    return ListView(
      children: [
        InfoCard(
          title: 'Pythagorean mapping',
          child: Column(
            children: pythRows
                .map(
                  (row) => NumberMappingRow(
                    label: row.label,
                    characters: row.characters,
                    numbers: row.numbers,
                    total: row.total,
                    reduced: row.reduced,
                  ),
                )
                .toList(growable: false),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        InfoCard(
          title: 'Chaldean mapping',
          child: Column(
            children: chaldeanRows
                .map(
                  (row) => NumberMappingRow(
                    label: row.label,
                    characters: row.characters,
                    numbers: row.numbers,
                    total: row.total,
                    reduced: row.reduced,
                  ),
                )
                .toList(growable: false),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        InfoCard(
          title: 'Aligned results',
          child: Column(
            children: [
              NumerologyResultTable(
                title: 'Pythagorean',
                rows: pythSummary,
              ),
              const SizedBox(height: AppSpacing.sm),
              NumerologyResultTable(
                title: 'Chaldean',
                rows: chaldeanSummary,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        InfoCard(
          title: 'Lucky / unlucky numbers',
          child: LuckyUnluckyPanel(
            lucky: lucky,
            unlucky: unlucky,
            destiny: destiny,
          ),
        ),
      ],
    );
  }

  Widget _buildPyramidSection(NumerologyReport? report) {
    if (report == null) {
      return const Center(child: Text('Enter name and valid birth date.'));
    }
    final rows = _pyramidRows(report.pyramid);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: InfoCard(
          title: 'Live pyramid',
          child: Column(
            children: [
              PyramidView(rows: rows),
              const SizedBox(height: AppSpacing.sm),
              Text(
                report.pyramidPrediction,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<(String, String)> _buildCombinations() {
    final parts = _nameParts();
    final first = parts.isNotEmpty ? parts.first : '';
    final surname = parts.length > 1 ? parts.last : '';
    final firstInitial = first.isNotEmpty ? first[0] : '';
    final surnameInitial = surname.isNotEmpty ? surname[0] : '';

    final values = <(String, String)>[
      ('first name + surname', '$first$surname'),
      ('first name + surname initial', '$first$surnameInitial'),
      ('first name only', first),
      ('surname only', surname),
      ('surname + first name initial', '$surname$firstInitial'),
    ];

    return values
        .map((entry) => (entry.$1, entry.$2.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '')))
        .toList(growable: false);
  }

  _MappedValue _buildMappedValue(
    String label,
    String chars,
    int Function(String) mapper,
  ) {
    final numbers = chars.split('').map(mapper).toList(growable: false);
    final total = numbers.fold<int>(0, (sum, value) => sum + value);
    return _MappedValue(
      label: label,
      characters: chars,
      numbers: numbers,
      total: total,
      reduced: _reduce(total),
    );
  }

  int _pythagoreanValue(String char) {
    for (var i = 0; i < _pythagoreanGroups.length; i++) {
      if (_pythagoreanGroups[i].contains(char)) {
        return i + 1;
      }
    }
    return 0;
  }

  int _chaldeanValue(String char) => _chaldeanMap[char] ?? 0;

  int _reduce(int value) {
    var current = value;
    while (current > 9) {
      current = current
          .toString()
          .split('')
          .map(int.parse)
          .fold<int>(0, (sum, digit) => sum + digit);
    }
    return current;
  }

  List<List<int>> _pyramidRows(List<int> base) {
    if (base.length < 4) {
      return const [];
    }

    final second = [
      _reduce(base[0] + base[1]),
      _reduce(base[1] + base[2]),
      _reduce(base[2] + base[3]),
    ];
    final third = [
      _reduce(second[0] + second[1]),
      _reduce(second[1] + second[2]),
    ];
    final top = [_reduce(third[0] + third[1])];

    return [top, third, second, base];
  }

  Widget _buildNamingTab() {
    final pools = _namingTarget == _NamingTarget.person ? _localNamePool : _cloudNamePool;
    final selectedLetters = _lettersControllers
        .map((controller) => controller.text.trim().toUpperCase())
        .where((letter) => letter.isNotEmpty)
        .toSet();

    final filtered = pools.where((name) {
      if (selectedLetters.isEmpty) {
        return true;
      }
      return selectedLetters.any((letter) => name.toUpperCase().startsWith(letter));
    }).take(_suggestionCount).toList(growable: false);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        InfoCard(
          title: 'Name suggestions',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SegmentedButton<_NamingTarget>(
                segments: const [
                  ButtonSegment(value: _NamingTarget.person, label: Text('Person')),
                  ButtonSegment(value: _NamingTarget.company, label: Text('Company')),
                ],
                selected: {_namingTarget},
                onSelectionChanged: (selection) {
                  setState(() {
                    _namingTarget = selection.first;
                    _selectedSuggestion = null;
                  });
                },
              ),
              const SizedBox(height: AppSpacing.xs),
              DropdownButtonFormField<int>(
                value: _suggestionCount,
                decoration: const InputDecoration(labelText: 'Number of names'),
                items: const [3, 5, 8, 10]
                    .map((value) => DropdownMenuItem(value: value, child: Text('$value')))
                    .toList(growable: false),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _suggestionCount = value;
                  });
                },
              ),
              const SizedBox(height: AppSpacing.xs),
              Text('Starting letters (up to 6)', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: _lettersControllers
                    .map(
                      (controller) => SizedBox(
                        width: 48,
                        child: TextField(
                          controller: controller,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          decoration: const InputDecoration(counterText: ''),
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        InfoCard(
          title: 'Suggested names',
          trailing: Text('${filtered.length}'),
          child: filtered.isEmpty
              ? const Text('No suggestions for selected letters.')
              : Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: filtered
                      .map(
                        (name) => ChoiceChip(
                          selected: _selectedSuggestion == name,
                          label: Text(name),
                          onSelected: (_) {
                            setState(() {
                              _selectedSuggestion = name;
                            });
                          },
                        ),
                      )
                      .toList(growable: false),
                ),
        ),
        const SizedBox(height: AppSpacing.sm),
        FilledButton.icon(
          onPressed: _selectedSuggestion == null
              ? null
              : () {
                  _nameController.text = _selectedSuggestion!;
                },
          icon: const Icon(Icons.edit_note),
          label: const Text('Use selected in Calculator'),
        ),
      ],
    );
  }

  Widget _buildHistoryTab() {
    final query = _historySearchController.text.trim().toLowerCase();
    final records = _historyRecords.where((record) {
      if (query.isEmpty) {
        return true;
      }
      return record.surname.toLowerCase().contains(query) || record.phone.contains(query);
    }).toList(growable: false);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: TextField(
            controller: _historySearchController,
            decoration: const InputDecoration(
              labelText: 'Search surname or phone',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              0,
              AppSpacing.md,
              AppSpacing.md,
            ),
            itemBuilder: (context, index) {
              final record = records[index];
              return HistoryProfileListItem(
                name: record.name,
                surname: record.surname,
                phone: record.phone,
                dateOfBirth: record.dateOfBirth,
                source: record.source,
                kind: record.kind,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.xs),
            itemCount: records.length,
          ),
        ),
      ],
    );
  }
}

class _MappedValue {
  const _MappedValue({
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
}

enum _NamingTarget { person, company }

class _HistoryRecord {
  const _HistoryRecord(
    this.name,
    this.surname,
    this.phone,
    this.dateOfBirth,
    this.source,
    this.kind,
  );

  final String name;
  final String surname;
  final String phone;
  final String dateOfBirth;
  final String source;
  final String kind;
}
