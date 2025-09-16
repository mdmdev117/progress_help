// file: summary_page.dart

import 'package:flutter/material.dart';
import 'package:progresshelp/styles/gradient_background.dart';
import 'styles/app_styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'question_page.dart'; // Per getQuestionsForCategory

class SummaryPage extends StatelessWidget {
  final String category;
  final Map<String, String> answers;

  const SummaryPage({super.key, required this.category, required this.answers});

  Future _sendEmail(BuildContext context) async {
    final subject = 'Richiesta di supporto: $category';

    // Ottieni le domande originali per questa categoria
    final questions = getQuestionsForCategory(category);

    // Crea un corpo email ben strutturato
    String body = '''
Richiesta di supporto
Categoria: $category

---
''';

    for (var entry in answers.entries) {
      final question = questions.firstWhere(
        (q) => q.key == entry.key,
        orElse: () => Question(entry.key, entry.key),
      );
      body += '''
Domanda:
${question.text}

Risposta:
${entry.value}

---
''';
    }

    final now = DateTime.now();
    body +=
        'Inviato da Gestione Presenze il ${now.day}/${now.month}/${now.year} alle ${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    // Codifica soggetto e corpo
    final encodedSubject = Uri.encodeComponent(subject);
    final encodedBody = Uri.encodeComponent(body);

    final mailtoLink =
        'mailto:your_email@example.com'
        '?subject=$encodedSubject'
        '&body=$encodedBody';

    try {
      final uri = Uri.parse(mailtoLink);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Nessun client email disponibile.')),
          );
        }
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Errore durante l\'invio dell\'email.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text('Riepilogo - $category')),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Expanded(
                child: ListView.builder(
                  itemCount: answers.length,
                  itemBuilder: (context, index) {
                    final entry = answers.entries.elementAt(index);
                    final question = getQuestionsForCategory(
                      category,
                    ).firstWhere(
                      (q) => q.key == entry.key,
                      orElse: () => Question(entry.key, entry.key),
                    );
                    return Card(
                      color: Colors.white.withOpacity(0.1),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Domanda:',
                              style: TextStyle(
                                color: Colors.blue[200],
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              question.text,
                              style: TextStyle(
                                color: Colors.blue[50],
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Risposta:',
                              style: TextStyle(
                                color: Colors.green[200],
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              entry.value,
                              style: TextStyle(
                                color: Colors.green[50],
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: AppStyles.elevatedButtonStyle,
                    child: const Text('Torna indietro'),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.email),
                    label: const Text('Invia via email'),
                    onPressed: () => _sendEmail(context),
                    style: AppStyles.elevatedButtonStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
