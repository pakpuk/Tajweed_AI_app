import 'package:flutter/material.dart';
import 'package:quran_app/service/ai_service.dart';

class QuizProvider with ChangeNotifier {
  List questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  bool isLoading = false;
  bool isQuizFinished = false;

  Future<void> fetchQuiz(String topic) async {
    isLoading = true;
    isQuizFinished = false;
    notifyListeners();

    try {
      questions = await AIService.generateQuiz(topic);
      currentQuestionIndex = 0;
      score = 0;
    } catch (e) {
      print('Error fetching quiz: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  void checkAnswer(String selectedOption) {
    if (questions.isNotEmpty &&
        selectedOption == questions[currentQuestionIndex]['correct_answer']) {
      score++;
    }
    nextQuestion();
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
    } else {
      isQuizFinished = true;
    }
    notifyListeners();
  }

  void restartQuiz() {
    currentQuestionIndex = 0;
    score = 0;
    isQuizFinished = false;
    notifyListeners();
  }

  void resetQuiz() {
    questions = [];
    currentQuestionIndex = 0;
    score = 0;
    isQuizFinished = false;
    notifyListeners();
  }

  int get totalQuestions => questions.length;
}
