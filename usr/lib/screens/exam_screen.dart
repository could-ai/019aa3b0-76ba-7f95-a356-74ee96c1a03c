import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/question.dart';
import 'package:couldai_user_app/screens/result_screen.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  // Sample Questions Data
  final List<Question> _questions = [
    Question(
      questionText: 'What is the capital of France?',
      options: ['London', 'Berlin', 'Paris', 'Madrid'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'Which programming language is used for Flutter?',
      options: ['Java', 'Kotlin', 'Dart', 'Swift'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'Who is the King of the Jungle?',
      options: ['Tiger', 'Lion', 'Elephant', 'Bear'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'What is 5 + 7?',
      options: ['10', '11', '12', '13'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'Which planet is known as the Red Planet?',
      options: ['Earth', 'Mars', 'Jupiter', 'Venus'],
      correctOptionIndex: 1,
    ),
  ];

  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  int _score = 0;

  void _answerQuestion() {
    if (_selectedOptionIndex == null) return;

    if (_selectedOptionIndex == _questions[_currentQuestionIndex].correctOptionIndex) {
      _score++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
      });
    } else {
      // Navigate to Result Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: _score,
            totalQuestions: _questions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentQuestionIndex + 1}/${_questions.length}'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / _questions.length,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
            ),
            const SizedBox(height: 30),
            Text(
              question.questionText,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),
            ...List.generate(question.options.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedOptionIndex = index;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: _selectedOptionIndex == index
                        ? Colors.indigo.shade50
                        : Colors.white,
                    side: BorderSide(
                      color: _selectedOptionIndex == index
                          ? Colors.indigo
                          : Colors.grey.shade400,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: _selectedOptionIndex == index
                              ? Colors.indigo
                              : Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            String.fromCharCode(65 + index), // A, B, C, D
                            style: TextStyle(
                              color: _selectedOptionIndex == index
                                  ? Colors.white
                                  : Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          question.options[index],
                          style: TextStyle(
                            fontSize: 18,
                            color: _selectedOptionIndex == index
                                ? Colors.indigo
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const Spacer(),
            ElevatedButton(
              onPressed: _selectedOptionIndex == null ? null : _answerQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _currentQuestionIndex == _questions.length - 1
                    ? 'Finish Exam'
                    : 'Next Question',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
