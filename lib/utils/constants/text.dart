import 'package:flutter/material.dart';
import 'colors.dart';

class TText {
  TText._();

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    color: tPrimaryColor,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w800,
  );

  static TextStyle headlineMedium = const TextStyle(
    fontSize: 30,
    color: tOnBackgroundColor,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 20,
    color: tOnBackgroundColor,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w800,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    color: tOnBackgroundColor,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 15,
    color: tOnBackgroundColor,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 15,
    color: tonContainerColor,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    color: tonContainerColor,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    color: tonContainerColor,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w300,
  );
}
