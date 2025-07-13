// file: question_page.dart
import 'package:flutter/material.dart';
import 'package:progresshelp/styles/gradient_background.dart';
import 'summary_page.dart';
import 'styles/app_styles.dart';

class QuestionPage extends StatefulWidget {
  final String category;
  const QuestionPage({super.key, required this.category});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int _currentIndex = 0;
  final Map<String, String> _answers = {};
  final TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = false;

  late List<Question> questions;

  @override
  void initState() {
    super.initState();
    questions = getQuestionsForCategory(widget.category);
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _isButtonEnabled = _controller.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        _controller.clear();
        _isButtonEnabled = false;
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
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          widget.category,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 120),
              Text(question.text, style: AppStyles.questionStyle),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: AppStyles.inputDecoration('Scrivi la risposta...'),
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
              ),
              const SizedBox(height: 24),
              


ElevatedButton(
  onPressed: _isButtonEnabled
      ? () => _nextQuestion(_controller.text.trim())
      : null,
  style: AppStyles.elevatedButtonStyle.copyWith(
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.white.withAlpha(20); // disabilitato: bianco trasparente
        }
        return AppStyles.buttonColor; // attivo: blu semi-trasparente
      },
    ),
    foregroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.white.withAlpha(80); // testo bianco più chiaro disattivato
        }
        return Colors.white; // testo bianco attivo
      },
    ),
    elevation: WidgetStateProperty.resolveWith<double>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return 0;
        }
        return 4;
      },
    ),
  ),
  child: const Text('Avanti'),
),


            ],
          ),
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
      return [Question('descrizione', 'Descrivi la tua richiesta.')];
  }
}
