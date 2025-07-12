// file: main.dart
import 'package:flutter/material.dart';
import 'package:progresshelp/gradient_background.dart';
import 'package:progresshelp/program_carousel_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestione Presenze',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
          scrolledUnderElevation: 0, // blocca ombra in scroll
        ),
      ),
      home: GradientBackground(
        child: ProgramCarouselPage(),
      ),
    );
  }
}
