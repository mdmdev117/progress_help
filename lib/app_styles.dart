// file: app_styles.dart
import 'package:flutter/material.dart';

class AppStyles {
  // Colori generali
  static const Color textColor = Colors.white;
  static const Color buttonColor = Colors.blueAccent;

  // Titolo grande
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle questionStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  // Testo normale
  static const TextStyle bodyStyle = TextStyle(fontSize: 16, color: textColor);

  // Pulsante
  static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: buttonColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  );

  // Input field
  static InputDecoration inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.white70),
    filled: true,
    fillColor: Colors.white.withAlpha(30),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
  );

  // AppBar
  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    foregroundColor: textColor,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent, // evita overlay bianco
  );
}
