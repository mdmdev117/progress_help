// file: summary_page.dart
import 'package:flutter/material.dart';
import 'package:progresshelp/gradient_background.dart';
import 'app_styles.dart';

class SummaryPage extends StatelessWidget {
  final String category;
  final Map<String, String> answers;

  const SummaryPage({super.key, required this.category, required this.answers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Riepilogo - $category'),
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 120),
              const Text(
                'Risposte:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: ListView(
                  children: answers.entries
                      .map((entry) => ListTile(
                            title: Text(entry.key, style: const TextStyle(color: Colors.white)),
                            subtitle: Text(entry.value, style: const TextStyle(color: Colors.white70)),
                          ))
                      .toList(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: AppStyles.elevatedButtonStyle,
                child: const Text('Torna indietro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
