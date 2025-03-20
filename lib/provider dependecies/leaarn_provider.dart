import 'package:flutter/material.dart';
import 'package:quran_app/service/ai_service.dart';
import 'package:quran_app/service/progress_service.dart';

class LearnProvider with ChangeNotifier {
  String? _selectedLesson;
  String _markdownContent = "";
  bool _isLoading = false;
  List<String> _completedLessons = [];
  int _currentLessonIndex = 0;
  List<String> _lessonList = [
    "Introduction to Tajweed",
    "Rules of Noon and Meem",
    "Madd (Prolongation)",
    "Qalqalah (Echoing Sound)",
    "Makharij (Articulation Points)"
  ];

  String? get selectedLesson => _selectedLesson;
  String get markdownContent => _markdownContent;
  bool get isLoading => _isLoading;
  List<String> get completedLessons => _completedLessons;
  int get totalLessons => _lessonList.length;
  int get currentLessonIndex => _currentLessonIndex;
  String get currentLessonTitle => _lessonList[_currentLessonIndex];

  Future<void> loadCompletedLessons() async {
    _completedLessons = await ProgressService.getCompletedLessons();
    notifyListeners();
  }

  Future<void> generateLessonContent(String lesson) async {
    _selectedLesson = lesson;
    _isLoading = true;
    notifyListeners();

    try {
      final content = await AIService.generateLessonContent(lesson);
      _markdownContent = content;
    } catch (e) {
      _markdownContent = "Failed to load content. Please try again.";
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markLessonCompleted() async {
    String lesson = _lessonList[_currentLessonIndex];
    await ProgressService.saveLessonCompletion(lesson);
    await loadCompletedLessons();
  }

  void nextLesson() {
    if (_currentLessonIndex < _lessonList.length - 1) {
      _currentLessonIndex++;
      generateLessonContent(_lessonList[_currentLessonIndex]);
    }
  }

  void previousLesson() {
    if (_currentLessonIndex > 0) {
      _currentLessonIndex--;
      generateLessonContent(_lessonList[_currentLessonIndex]);
    }
  }
}
