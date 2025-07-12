// file: category_page.dart
import 'package:flutter/material.dart';
import 'question_page.dart';


class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});
  final List<String> categories = [
    'Nuova voce presenze',
    'Modifica cartellino',
    'Errore gestione presenze',
    'Report personalizzati',
    'Altro',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scegli la categoria'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  category,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionPage(category: category),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
