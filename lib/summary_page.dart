// file: summary_page.dart
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';


class SummaryPage extends StatelessWidget {
  final String category;
  final Map<String, String> answers;

  const SummaryPage({super.key, required this.category, required this.answers});

  void _generateAndPrintPdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Richiesta - $category', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              ...answers.entries.map(
                (entry) => pw.Text('${entry.key}: ${entry.value}'),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Riepilogo - $category')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Risposte:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: answers.entries
                    .map((entry) => ListTile(
                          title: Text(entry.key),
                          subtitle: Text(entry.value),
                        ))
                    .toList(),
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Genera PDF ed invia'),
              onPressed: () => _generateAndPrintPdf(context),
            ),
          ],
        ),
      ),
    );
  }
}
