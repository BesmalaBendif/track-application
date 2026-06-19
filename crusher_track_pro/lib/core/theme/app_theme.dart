import 'package:flutter/material.dart';

class AppTheme {
  // ================= LIGHT THEME =================

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    scaffoldBackgroundColor: const Color(0xFFF8FAFC),

    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2563EB),
      brightness: Brightness.light,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF8FAFC),
      foregroundColor: Color(0xFF0F172A),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),

    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFFFFFFFF),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(
          color: Color(0xFFE2E8F0),
        ),
      ),
    ),

    iconTheme: const IconThemeData(
      color: Color(0xFF0F172A),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Color(0xFF0F172A),
      ),
      bodyMedium: TextStyle(
        color: Color(0xFF64748B),
      ),
      titleLarge: TextStyle(
        color: Color(0xFF0F172A),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: Color(0xFFE2E8F0),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xFF2563EB),
          width: 1.5,
        ),
      ),
    ),
  );

  // ================= DARK THEME =================

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Main background
    scaffoldBackgroundColor: const Color(0xFF020817),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF2563EB),
      secondary: Color(0xFF2563EB),
      surface: Color(0xFF0F172A),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF020817),
      foregroundColor: Color(0xFFF8FAFC),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),

    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFF020817),
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFF0F172A),
      elevation: 0,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),

        side: const BorderSide(
          color: Color(0xFF1E293B),
        ),
      ),
    ),

    iconTheme: const IconThemeData(
      color: Color(0xFFF8FAFC),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Color(0xFFF8FAFC),
      ),

      bodyMedium: TextStyle(
        color: Color(0xFF94A3B8),
      ),

      titleLarge: TextStyle(
        color: Color(0xFFF8FAFC),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: Color(0xFF1E293B),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF0F172A),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        borderSide: const BorderSide(
          color: Color(0xFF1E293B),
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        borderSide: const BorderSide(
          color: Color(0xFF1E293B),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        borderSide: const BorderSide(
          color: Color(0xFF2563EB),
          width: 1.5,
        ),
      ),
    ),
  );
}