import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: Colors.white,
    fontFamily: 'Cairo',
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      secondary: Colors.white,
      surface: AppColors.darkCard,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Cairo',
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.darkTextPrimary,
        fontFamily: 'Cairo',
      ),
      bodyMedium: TextStyle(
        color: AppColors.darkTextPrimary,
        fontFamily: 'Cairo',
      ),
      titleLarge: TextStyle(
        color: AppColors.darkTextPrimary,
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
      ),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: Colors.black,
    fontFamily: 'Cairo',
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      secondary: Colors.black,
      surface: AppColors.lightCard,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Cairo',
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.lightTextPrimary,
        fontFamily: 'Cairo',
      ),
      bodyMedium: TextStyle(
        color: AppColors.lightTextPrimary,
        fontFamily: 'Cairo',
      ),
      titleLarge: TextStyle(
        color: AppColors.lightTextPrimary,
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
      ),
    ),
  );
}
