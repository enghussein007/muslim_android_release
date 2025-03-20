import 'package:flutter/material.dart';

import 'colors.dart';

class Themes{

  static ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    appBarTheme: const AppBarTheme(
      backgroundColor: energy,
      foregroundColor: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    appBarTheme: const AppBarTheme(
      backgroundColor: energy,
      foregroundColor: Colors.white,
    ),
  );






}