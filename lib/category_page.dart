// file: category_page.dart
import 'package:flutter/material.dart';
import 'package:progresshelp/gradient_background.dart';
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
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Scegli la categoria', style:  TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
        ),
        body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                color: Colors.white.withAlpha(5), // <-- trasparenza!
  elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),

                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(
                    category,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500,    color: Colors.white,),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
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
      ),
    );
  }
}
