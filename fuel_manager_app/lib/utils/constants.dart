import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2E7D32);
  static const Color primaryLight = Color(0xFF60AD5E);
  static const Color primaryDark = Color(0xFF005005);
  static const Color secondary = Color(0xFFFF6F00);
  static const Color secondaryLight = Color(0xFFFFA040);
  static const Color secondaryDark = Color(0xFFC43E00);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFFFA000);
  static const Color gasoline = Color(0xFF1976D2);
  static const Color ethanol = Color(0xFF388E3C);
  static const Color diesel = Color(0xFF5D4037);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}

class FuelTypes {
  static const String gasoline = 'gasoline';
  static const String ethanol = 'ethanol';
  static const String diesel = 'diesel';

  static String getLabel(String type) {
    switch (type) {
      case gasoline:
        return 'Gasolina';
      case ethanol:
        return 'Álcool';
      case diesel:
        return 'Diesel';
      default:
        return type;
    }
  }

  static Color getColor(String type) {
    switch (type) {
      case gasoline:
        return AppColors.gasoline;
      case ethanol:
        return AppColors.ethanol;
      case diesel:
        return AppColors.diesel;
      default:
        return Colors.grey;
    }
  }

  static IconData getIcon(String type) {
    switch (type) {
      case gasoline:
        return Icons.local_gas_station;
      case ethanol:
        return Icons.eco;
      case diesel:
        return Icons.oil_barrel;
      default:
        return Icons.local_gas_station;
    }
  }
}

class CarFuelTypes {
  static const String flex = 'flex';
  static const String gasoline = 'gasoline';
  static const String ethanol = 'ethanol';
  static const String diesel = 'diesel';

  static String getLabel(String type) {
    switch (type) {
      case flex:
        return 'Flex';
      case gasoline:
        return 'Gasolina';
      case ethanol:
        return 'Álcool';
      case diesel:
        return 'Diesel';
      default:
        return type;
    }
  }

  static List<String> getAvailableFuelTypes(String carFuelType) {
    switch (carFuelType) {
      case flex:
        return [FuelTypes.gasoline, FuelTypes.ethanol];
      case gasoline:
        return [FuelTypes.gasoline];
      case ethanol:
        return [FuelTypes.ethanol];
      case diesel:
        return [FuelTypes.diesel];
      default:
        return [FuelTypes.gasoline, FuelTypes.ethanol];
    }
  }
}
