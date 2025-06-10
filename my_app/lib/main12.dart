import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: QuizApp()));

class Question {
  final String question;
  final List<String> options;
  final int answerIndex;

  Question(this.question, this.options, this.answerIndex);
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int currentQuestion = 0;
  int score = 0;

  final List<Question> questions = [
    Question("What is the capital of India?", ["Delhi", "Mumbai", "Chennai", "Kolkata"], 0),
    Question("Flutter is developed by?", ["Facebook", "Google", "Microsoft", "Apple"], 1),
    Question("Which language is used in Flutter?", ["Kotlin", "Swift", "Java", "Dart"], 3),
  ];

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == questions[currentQuestion].answerIndex) {
      score++;
    }
    setState(() {
      currentQuestion++;
    });
  }

  void resetQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isQuizFinished = currentQuestion >= questions.length;

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz App")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isQuizFinished
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Quiz Completed!",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Your Score: $score / ${questions.length}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: resetQuiz,
                    child: const Text("Restart Quiz"),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Q${currentQuestion + 1}: ${questions[currentQuestion].question}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  ...List.generate(
                    questions[currentQuestion].options.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(
                        onPressed: () => checkAnswer(index),
                        child: Text(questions[currentQuestion].options[index]),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
