import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 76, 175, 85),
      secondary: Color.fromARGB(255, 203, 241, 205),
      tertiary: Color.fromARGB(255, 212, 237, 218),
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onTertiary: Colors.black,
      surface: const Color(0xFFFFFFFF),
      onSurface: const Color(0xFF111111),
      error: const Color(0xFFFA5252),
      onError: Colors.white,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 66, 66, 66),
      secondary: Color.fromARGB(255, 214, 214, 214),
      tertiary: const Color.fromARGB(255, 238, 238, 238),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onTertiary: Colors.white,
      surface: const Color(0xFFFFFFFF),
      onSurface: const Color(0xFF111111),
      error: const Color(0xFFFA5252),
      onError: Colors.white,
    ),
  );
}
