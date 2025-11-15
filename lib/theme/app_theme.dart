import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF7C4DFF);
  static const Color onPrimary = Colors.white;
  static const Color accentColor = Color(0xFF00E5FF);
  static const Color bg = Color(0xFF0B0F1A);
  static const Color surface = Color(0xFF0F1724);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB9C1D9);

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      onPrimary: onPrimary,
      secondary: accentColor,
      surface: surface,
      background: bg,
      onSurface: textPrimary,
    ),
    scaffoldBackgroundColor: bg,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF10151F),
      elevation: 0,
      centerTitle: true,
      foregroundColor: textPrimary,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF0E1622),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      labelStyle: TextStyle(color: textSecondary),
    ),
    cardTheme: CardThemeData(
      color: Color(0xFF0F1724),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      elevation: 4,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: textPrimary, fontSize: 18, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(color: textSecondary),
    ),
    iconTheme: const IconThemeData(color: textPrimary),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
