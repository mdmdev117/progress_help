// file: question_page.dart
import 'package:flutter/material.dart';
import 'summary_page.dart';

class QuestionPage extends StatefulWidget {
  final String category;
  const QuestionPage({super.key, required this.category});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int _currentIndex = 0;
  final Map<String, String> _answers = {};

  late List<Question> questions;

  @override
  void initState() {
    super.initState();
    questions = getQuestionsForCategory(widget.category);
  }

  void _nextQuestion(String answer) {
    final currentKey = questions[_currentIndex].key;
    _answers[currentKey] = answer;

    int nextIndex = _currentIndex + 1;

    // Esempio di salto domanda condizionale
    if (questions[_currentIndex].key == 'retribuita') {
      if (answer.toLowerCase() == 'no') {
        nextIndex++; // salta una domanda
      }
    }

    if (nextIndex < questions.length) {
      setState(() {
        _currentIndex = nextIndex;
      });
    } else {
      _showSummary();
    }
  }

  void _showSummary() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryPage(
          category: widget.category,
          answers: _answers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question.text,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            TextField(
              onSubmitted: _nextQuestion,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Risposta',
              ),
              autofocus: true,
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String key;
  final String text;
  Question(this.key, this.text);
}

List<Question> getQuestionsForCategory(String category) {
  switch (category) {
    case 'Nuova voce presenze':
      return [
        Question('nome_voce', 'Come si deve chiamare la nuova voce?'),
        Question('retribuita', 'È una voce retribuita? (sì/no)'),
        Question('codice_cartellino', 'Con quale codice va nel cartellino?'),
        Question('regole', 'Ci sono regole particolari di calcolo?'),
      ];
    case 'Modifica cartellino':
      return [
        Question('campo', 'Quale campo del cartellino va modificato?'),
        Question('nuovo_valore', 'Qual è il nuovo valore da impostare?'),
      ];
    default:
      return [
        Question('descrizione', 'Descrivi la tua richiesta.'),
      ];
  }
}
