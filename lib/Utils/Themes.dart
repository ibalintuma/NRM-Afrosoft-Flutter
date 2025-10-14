
import 'package:flutter/material.dart';

import 'Helper.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.grey.shade100,
  primaryColor: Colors.grey.shade900,
  primaryColorLight: Colors.grey.shade800,
  primaryColorDark: Colors.grey.shade700,
  colorScheme: ColorScheme.light(
    secondary: Colors.grey.shade100,
  ),
  cardColor: Colors.grey.shade300,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade200,
    foregroundColor: Colors.grey.shade900,
  ),
); // ThemeData.light

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey.shade800,
  primaryColor: Colors.grey.shade800,
  primaryColorLight: Colors.grey.shade700,
  primaryColorDark: Colors.grey.shade600,
  colorScheme: ColorScheme.dark(
    secondary: Colors.grey.shade700,
  ),
  cardColor: Colors.grey.shade900,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade900,
    foregroundColor: Colors.white,
  ),
); // ThemeData.dark