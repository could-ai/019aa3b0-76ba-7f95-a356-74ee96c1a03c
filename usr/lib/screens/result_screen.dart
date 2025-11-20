import 'package:flutter/material.dart';
import 'package:couldai_user_app/widgets/web_layout.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (score / totalQuestions) * 100;
    String message;
    Color color;
    IconData icon;

    if (percentage >= 80) {
      message = 'Excellent Job, King!';
      color = Colors.green;
      icon = Icons.emoji_events;
    } else if (percentage >= 50) {
      message = 'Good Effort!';
      color = Colors.amber;
      icon = Icons.thumb_up;
    } else {
      message = 'Keep Practicing!';
      color = Colors.red;
      icon = Icons.school;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Results'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: WebLayout(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 80, color: color),
                const SizedBox(height: 24),
                const Text(
                  'Your Score',
                  style: TextStyle(fontSize: 24, color: Colors.grey, letterSpacing: 1.1),
                ),
                const SizedBox(height: 32),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: CircularProgressIndicator(
                        value: score / totalQuestions,
                        strokeWidth: 20,
                        backgroundColor: Colors.grey.shade100,
                        color: color,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '$score / $totalQuestions',
                          style: TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        Text(
                          '${percentage.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 16),
                if (percentage < 100)
                  const Text(
                    "Don't give up! Try again to reach perfection.",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                const SizedBox(height: 60),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  icon: const Icon(Icons.home_rounded),
                  label: const Text('Back to Home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
