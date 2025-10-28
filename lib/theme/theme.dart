import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
    fontFamily: 'Antonio',
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: Colors.white,
        primary: Colors.grey.shade300,
        secondary: Colors.grey.shade400,
        tertiary: Colors.black));

ThemeData darkmode = ThemeData(
    fontFamily: 'Antonio',
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        surface: Colors.black12,
        primary: Colors.grey.shade900,
        secondary: Colors.grey.shade800,
        tertiary: Colors.white));
