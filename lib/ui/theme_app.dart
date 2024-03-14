import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData theme({bool darkTheme = true}) {
    return ThemeData(
      brightness: darkTheme ? Brightness.dark : Brightness.light,
      useMaterial3: true,
      colorSchemeSeed: Colors.amber,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      )
    );
  }
}
