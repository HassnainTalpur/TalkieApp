import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text.dart';

var lightTheme = ThemeData();
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  appBarTheme: const AppBarTheme(backgroundColor: tContainerColor),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: tBackgroundColor,
    filled: true,
    border: UnderlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  colorScheme: const ColorScheme.dark(
    primary: tPrimaryColor,
    onPrimary: tOnBackgroundColor,
    surface: tBackgroundColor,
    primaryContainer: tContainerColor,
    onPrimaryContainer: tonContainerColor,
  ),
  textTheme: TextTheme(
    headlineLarge: const TextStyle(
      fontSize: 32,
      color: tPrimaryColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w800,
    ),
    headlineMedium: const TextStyle(
      fontSize: 30,
      color: tOnBackgroundColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TText.headlineSmall.copyWith(color: tPrimaryColor),
    bodyLarge: const TextStyle(
      fontSize: 18,
      color: tOnBackgroundColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: const TextStyle(
      fontSize: 15,
      color: tOnBackgroundColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),
    labelLarge: const TextStyle(
      fontSize: 15,
      color: tonContainerColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    ),
    labelMedium: const TextStyle(
      fontSize: 12,
      color: tonContainerColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    ),
    labelSmall: const TextStyle(
      fontSize: 10,
      color: tonContainerColor,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
    ),
  ),
);
