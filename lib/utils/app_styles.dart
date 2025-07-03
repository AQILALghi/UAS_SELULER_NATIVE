
import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static const Color primary = Color(0xFF6200EE); // Deep Purple
  static const Color primaryDark = Color(0xFF3700B3); // Darker Purple
  static const Color accent = Color(0xFF03DAC6); // Teal
  static const Color background = Color(0xFFF0F2F5); // Light Grayish Blue
  static const Color card = Colors.white;
  static const Color textPrimary = Color(0xFF212121); // Dark Gray
  static const Color textSecondary = Color(0xFF616161); // Medium Gray
  static const Color error = Color(0xFFB00020); // Red
  static const Color success = Color(0xFF4CAF50); // Green

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFFBB86FC); // Light Purple
  static const Color darkPrimaryDark = Color(0xFF3700B3); // Darker Purple (same as light for consistency)
  static const Color darkAccent = Color(0xFF03DAC6); // Teal (same as light for consistency)
  static const Color darkBackground = Color(0xFF121212); // Deep Dark Gray
  static const Color darkCard = Color(0xFF1E1E1E); // Darker Gray
  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Color(0xFFB0B0B0); // Light Gray
}

class AppStyles {
  static final ThemeData appTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    primaryColor: AppColors.primary,
    primaryColorDark: AppColors.primaryDark,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.card,
      background: AppColors.background,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
      onBackground: AppColors.textPrimary,
      onError: Colors.white,
      primaryContainer: Color(0xFFBBDEFB), // Light Blue for gradients/containers
    ),
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 4,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
      displayMedium: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
      headlineLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      headlineMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      bodyLarge: TextStyle(fontSize: 18.0, color: AppColors.textPrimary),
      bodyMedium: TextStyle(fontSize: 16.0, color: AppColors.textSecondary),
      labelLarge: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        elevation: 5,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryDark,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.card,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: AppColors.primary, width: 2.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      labelStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
      hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.8), fontSize: 16),
      errorStyle: const TextStyle(color: AppColors.error, fontSize: 14, fontWeight: FontWeight.w500),
    ),
    cardTheme: CardThemeData(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
      color: AppColors.card,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.textPrimary,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      )
    ),
    // Add other theme properties as needed
  );

  static final ThemeData darkAppTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
    primaryColor: AppColors.darkPrimary,
    primaryColorDark: AppColors.darkPrimaryDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkAccent,
      surface: AppColors.darkCard,
      background: AppColors.darkBackground,
      error: AppColors.error,
      onPrimary: AppColors.darkTextPrimary,
      onSecondary: AppColors.darkTextPrimary,
      onSurface: AppColors.darkTextPrimary,
      onBackground: AppColors.darkTextPrimary,
      onError: AppColors.darkTextPrimary,
      primaryContainer: Color(0xFF212121), // Darker grey for containers
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkPrimaryDark,
      foregroundColor: AppColors.darkTextPrimary,
      elevation: 4,
      titleTextStyle: TextStyle(
        color: AppColors.darkTextPrimary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w900, color: AppColors.darkTextPrimary),
      displayMedium: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w800, color: AppColors.darkTextPrimary),
      headlineLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: AppColors.darkTextPrimary),
      headlineMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: AppColors.darkTextPrimary),
      bodyLarge: TextStyle(fontSize: 18.0, color: AppColors.darkTextPrimary),
      bodyMedium: TextStyle(fontSize: 16.0, color: AppColors.darkTextSecondary),
      labelLarge: TextStyle(fontSize: 18.0, color: AppColors.darkTextPrimary, fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.darkTextPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        elevation: 5,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.darkPrimary,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: AppColors.darkPrimary, width: 2.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: Colors.grey.shade700, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      labelStyle: const TextStyle(color: AppColors.darkTextSecondary, fontSize: 16),
      hintStyle: TextStyle(color: AppColors.darkTextSecondary.withOpacity(0.8), fontSize: 16),
      errorStyle: const TextStyle(color: AppColors.error, fontSize: 14, fontWeight: FontWeight.w500),
    ),
    cardTheme: CardThemeData(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
      color: AppColors.darkCard,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkAccent,
      foregroundColor: AppColors.darkTextPrimary,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      )
    ),
    // Add other theme properties as needed
  );

  static TextStyle get headingStyle => _currentTheme.textTheme.displayMedium!;
  static TextStyle get titleStyle => _currentTheme.textTheme.headlineLarge!;
  static TextStyle get subtitleStyle => _currentTheme.textTheme.headlineMedium!;
  static TextStyle get bodyStyle => _currentTheme.textTheme.bodyLarge!;
  static TextStyle get smallBodyStyle => _currentTheme.textTheme.bodyMedium!;
  static TextStyle get buttonTextStyle => _currentTheme.textTheme.labelLarge!;

  static ThemeData _currentTheme = appTheme;

  static void setTheme(ThemeData theme) {
    _currentTheme = theme;
  }

  static BoxDecoration cardDecoration(BuildContext context) {
    final theme = Theme.of(context);
    return BoxDecoration(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: [
        BoxShadow(
          color: theme.brightness == Brightness.light
              ? Colors.grey.withOpacity(0.2)
              : Colors.black.withOpacity(0.4),
          spreadRadius: 3,
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}