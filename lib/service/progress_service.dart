import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  static const String _progressKey = 'completed_lessons';

  static Future<void> saveLessonCompletion(String lesson) async {
    final prefs = await SharedPreferences.getInstance();
    final completedLessons = prefs.getStringList(_progressKey) ?? [];
    if (!completedLessons.contains(lesson)) {
      completedLessons.add(lesson);
      await prefs.setStringList(_progressKey, completedLessons);
    }
  }

  static Future<List<String>> getCompletedLessons() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_progressKey) ?? [];
  }
}
