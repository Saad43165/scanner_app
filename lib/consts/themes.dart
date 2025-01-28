import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF82B1FF); // Purple
  static const Color accent = Color(0xFF6E76C8); // Light Purple
  static const Color navy = Color(0xFF283593); // Navy Blue
  static const Color gold = Color(0xFFFFD700); // Gold
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color textDark = Color(0xFF000000); // Darker Text
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: 'Oregano',
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
      displayMedium: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: AppColors.textDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: AppColors.grey,
      ),
      labelLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      labelStyle: TextStyle(color: AppColors.textDark),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
    ),
  );
}

class Responsive {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;

  static double textSize(BuildContext context, double size) {
    double baseWidth = 375.0; // Standard base width
    return size * (width(context) / baseWidth);
  }
}
