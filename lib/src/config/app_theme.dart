import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      textTheme: TextTheme(
        headlineLarge: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w500,
            color: AppColors.darkBackgroundColor),
        bodyLarge: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: AppColors.lightGrey),
        bodyMedium: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: AppColors.darkBackgroundColor),
        headlineMedium: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
            color: AppColors.darkBackgroundColor),
        headlineSmall: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: AppColors.lightGrey),
        displayMedium: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w400,
            color: AppColors.lightGrey),
        displaySmall: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: AppColors.darkBackgroundColor),
        displayLarge: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w400,
            color: AppColors.lightGrey),
        // Body text
// Button text
      ),
      primaryColor: AppColors.tallyColor,
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkBackgroundColor,
          centerTitle: false,
          elevation: 0),
      // colorScheme: ColorScheme(brightness: AppColors., primary: primary, onPrimary: onPrimary, secondary: secondary, onSecondary: onSecondary, error: error, onError: onError, background: background, onBackground: onBackground, surface: surface, onSurface: onSurface)
    );
  }

  static darkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      textTheme: TextTheme(
        headlineLarge: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w500,
            color: AppColors.darkBackgroundColor),
        bodyLarge: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: AppColors.lightGrey),
        bodyMedium: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: AppColors.darkBackgroundColor),
        headlineMedium: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
            color: AppColors.darkBackgroundColor),
        headlineSmall: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: AppColors.lightGrey),
        displayMedium: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w400,
            color: AppColors.lightGrey),
        displaySmall: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: AppColors.darkBackgroundColor),
        displayLarge: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w400,
            color: AppColors.lightGrey),
        // Body text
// Button text
      ),
      primaryColor: AppColors.tallyColor,
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkBackgroundColor,
          centerTitle: false,
          elevation: 0),
      // colorScheme: ColorScheme(brightness: AppColors., primary: primary, onPrimary: onPrimary, secondary: secondary, onSecondary: onSecondary, error: error, onError: onError, background: background, onBackground: onBackground, surface: surface, onSurface: onSurface)
    );
  }

  static themeMode({required bool isLight}) {
    return isLight ? ThemeMode.light : ThemeMode.dark;
  }
}
