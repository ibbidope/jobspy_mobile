import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    final base = ThemeData.light();

    return base.copyWith(
      scaffoldBackgroundColor: ColorConstants.surface,
      colorScheme: base.colorScheme.copyWith(
        primary: ColorConstants.primary,
        secondary: ColorConstants.accent,
        surface: ColorConstants.surface,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorConstants.surface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: ColorConstants.primary,
        ),
        iconTheme: IconThemeData(color: ColorConstants.primary),
      ),
      textTheme: base.textTheme.apply(
        fontFamily: 'Poppins',
        bodyColor: Colors.black87,
        displayColor: Colors.black87,
      ),
      primaryTextTheme: base.primaryTextTheme.apply(
        fontFamily: 'Poppins',
        bodyColor: Colors.black87,
        displayColor: Colors.black87,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.primary, width: 1.4),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
