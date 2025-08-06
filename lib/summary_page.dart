// file: summary_page.dart
import 'package:flutter/material.dart';
import 'package:progresshelp/styles/gradient_background.dart';
import 'styles/app_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class SummaryPage extends StatelessWidget {
  final String category;
  final Map<String, String> answers;

  const SummaryPage({super.key, required this.category, required this.answers});

  Future<void> _sendEmail(BuildContext context) async {
    final subject = 'Riepilogo - $category';
    final body = answers.entries.map((e) => '${e.key}: ${e.value}').join('\n');

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'your_email@example.com', // <-- opzionale, metti la tua se vuoi
      queryParameters: {'subject': subject, 'body': body},
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        // Mostra snackbar se nessun client disponibile
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Nessun client email disponibile.')),
          );
        }
      }
    } catch (e) {
      // Mostra snackbar in caso di errore
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
              const SizedBox(height: 120),
              const Text(
                'Risposte:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: ListView(
                  children:
                      answers.entries
                          .map(
                            (entry) => ListTile(
                              title: Text(
                                entry.key,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                entry.value,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: AppStyles.elevatedButtonStyle,
                    child: const Text('Torna indietro'),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.email),
                    label: const Text('Invia via email'),
                    onPressed:
                        () => _sendEmail(context), // <-- usa il context qui
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
