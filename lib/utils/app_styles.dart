import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF42A5F5);  
  static const Color primaryDark = Color(0xFF1976D2);  
  static const Color accent = Color(0xFFFFC107);  
  static const Color background = Color(0xFFF5F5F5); 
  static const Color card = Colors.white;
  static const Color textPrimary = Color(0xFF212121);  
  static const Color textSecondary = Color(0xFF757575); 
  static const Color error = Color(0xFFD32F2F);  
  static const Color success = Color(0xFF388E3C);  
}

class AppStyles {
  static final ThemeData appTheme = ThemeData(
    primarySwatch: Colors.blue,  
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
    ),
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,  
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,  
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      headlineMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      bodyLarge: TextStyle(fontSize: 16.0, color: AppColors.textPrimary),
      bodyMedium: TextStyle(fontSize: 14.0, color: AppColors.textSecondary),
      labelLarge: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),  
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), 
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        elevation: 3, 
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryDark,
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,  
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0), 
        borderSide: BorderSide.none,  
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: AppColors.primary, width: 2.0),  
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0), 
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      labelStyle: const TextStyle(color: AppColors.textSecondary),
      hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.7)),
      errorStyle: const TextStyle(color: AppColors.error, fontSize: 13),
    ),
    cardTheme: CardTheme(
      elevation: 4,  
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),  
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      color: AppColors.card,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,  
      foregroundColor: AppColors.textPrimary,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))  
      )
    ),
  );

  static TextStyle get headingStyle => appTheme.textTheme.displayMedium!;
  static TextStyle get titleStyle => appTheme.textTheme.headlineLarge!;
  static TextStyle get subtitleStyle => appTheme.textTheme.headlineMedium!;
  static TextStyle get bodyStyle => appTheme.textTheme.bodyLarge!;
  static TextStyle get smallBodyStyle => appTheme.textTheme.bodyMedium!;
  static TextStyle get buttonTextStyle => appTheme.textTheme.labelLarge!;

  static BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.card,
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.15),
        spreadRadius: 2,
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  );
}