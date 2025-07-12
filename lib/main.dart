// file: main.dart
import 'package:flutter/material.dart';
import 'package:progresshelp/gradient_background.dart';
import 'category_page.dart';

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
      //theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: GradientBackground(
        child: CategoryPage(),
      ),
    );
  }
}
