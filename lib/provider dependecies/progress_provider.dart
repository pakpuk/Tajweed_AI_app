import 'package:flutter/material.dart';

class ProgressProvider with ChangeNotifier {
  Set<String> _completedLessons = {};

  Set<String> get completedLessons => _completedLessons;

  void markLessonCompleted(String lessonId) {
    _completedLessons.add(lessonId);
    notifyListeners();
  }

  bool isLessonCompleted(String lessonId) {
    return _completedLessons.contains(lessonId);
  }
}
