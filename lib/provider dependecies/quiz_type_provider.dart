import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuizTypeProvider with ChangeNotifier {
  String? selectedCategory;
  List<dynamic> questions = [];
  bool isLoading = false;
  String errorMessage = '';

  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
    fetchQuestions(category);
  }

  Future<void> fetchQuestions(String category) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    final encodedCategory = Uri.encodeComponent(category);
    final url =
        Uri.parse('http://127.0.0.1:8000/api/generate_quiz/$encodedCategory/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        questions = json.decode(response.body);
      } else {
        errorMessage = 'Failed to load quiz.';
        questions = [];
      }
    } catch (e) {
      errorMessage = 'Network error. Please try again.';
      questions = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
