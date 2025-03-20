import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReciteProvider extends ChangeNotifier {
  String _selectedSurah = "Al-Kahf"; // Default Surah
  String _selectedVerses = "66-88"; // Default range
  String _recitedText = "";
  Map<String, dynamic> _aiFeedback = {};

  String get selectedSurah => _selectedSurah;
  String get selectedVerses => _selectedVerses;
  String get recitedText => _recitedText;
  Map<String, dynamic> get aiFeedback => _aiFeedback;

  void setSurah(String surah) {
    _selectedSurah = surah;
    notifyListeners();
  }

  void setVerses(String verses) {
    _selectedVerses = verses;
    notifyListeners();
  }

  void updateRecitation(String text) {
    _recitedText = text;
    notifyListeners();
  }

  Future<void> analyzeRecitation() async {
    if (_recitedText.isEmpty) return;

    try {
      final response = await http.post(
        Uri.parse('https://your-backend.com/analyze'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"text": _recitedText, "surah": _selectedSurah}),
      );

      if (response.statusCode == 200) {
        _aiFeedback = jsonDecode(response.body);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch AI feedback");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
