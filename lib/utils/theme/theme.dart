import 'package:flutter/material.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/text.dart';

var lightTheme = ThemeData();
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  appBarTheme: AppBarTheme(backgroundColor: tContainerColor),
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
    onSurface: tOnBackgroundColor,
    primaryContainer: tContainerColor,
    onPrimaryContainer: tonContainerColor,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      color: tPrimaryColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w800,
    ),
    headlineMedium: TextStyle(
      fontSize: 30,
      color: tOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TText.headlineSmall.copyWith(color: tPrimaryColor),
    bodyLarge: TextStyle(
      fontSize: 18,
      color: tOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      color: tOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w500,
    ),
    labelLarge: TextStyle(
      fontSize: 15,
      color: tonContainerColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      color: tonContainerColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      color: tonContainerColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w300,
    ),
  ),
);
