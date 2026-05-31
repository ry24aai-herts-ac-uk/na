import 'package:flutter/material.dart';

class AppSpacing {
  const AppSpacing._();

  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
}

class AppRadius {
  const AppRadius._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
}

class AppIconSizes {
  const AppIconSizes._();

  static const double sm = 14;
  static const double md = 18;
  static const double lg = 22;
}

class AppShadows {
  const AppShadows._();

  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];
}

class AppTabSizes {
  const AppTabSizes._();

  static const double height = 36;
  static const EdgeInsets indicatorPadding =
      EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: AppSpacing.xxs);
}

class AppColors {
  const AppColors._();

  static const chartBackground = Color(0xFFF6F7FB);
  static const chartCellBackground = Color(0xFFFFFFFF);
  static const successTint = Color(0xFFE8F5E9);
  static const warningTint = Color(0xFFFFF3E0);
  static const infoTint = Color(0xFFE8EAF6);
}

class AppTextStyles {
  const AppTextStyles._();

  static const label = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
  static const compactBody = TextStyle(fontSize: 13, height: 1.2);
  static const sectionTitle = TextStyle(fontSize: 15, fontWeight: FontWeight.w700);
  static const value = TextStyle(fontSize: 15, fontWeight: FontWeight.w700);
}

ThemeData buildAppTheme() {
  final base = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );

  return base.copyWith(
    visualDensity: VisualDensity.compact,
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      margin: const EdgeInsets.all(0),
      color: base.colorScheme.surface,
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    ),
  );
}
