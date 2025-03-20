import 'package:flutter/material.dart';

class LearningPlanProvider with ChangeNotifier {
  String _selectedProficiencyLevel = "";
  String _selectedLearningStyle = "";
  String _selectedArabicLevel = "";
  String _selectedAcademicLevel = "";
  String _selectedShariaLevel = "";
  String _selectedLessonLanguage = "";
  List<String> _selectedKnownTopics = [];
  List<String> _selectedFocusAreas = [];

  String get selectedProficiencyLevel => _selectedProficiencyLevel;
  String get selectedLearningStyle => _selectedLearningStyle;
  String get selectedArabicLevel => _selectedArabicLevel;
  String get selectedAcademicLevel => _selectedAcademicLevel;
  String get selectedShariaLevel => _selectedShariaLevel;
  String get selectedLessonLanguage => _selectedLessonLanguage;
  List<String> get selectedKnownTopics => _selectedKnownTopics;
  List<String> get selectedFocusAreas => _selectedFocusAreas;

  List<String> proficiencyLevels = ["Beginner", "Intermediate", "Advanced"];
  List<String> learningStyles = ["Visual", "Auditory", "Kinesthetic"];
  List<String> arabicLevels = ["Basic", "Intermediate", "Fluent"];
  List<String> academicLevels = ["School", "University", "Self-study"];
  List<String> shariaLevels = ["None", "Basic", "Advanced"];
  List<String> lessonLanguages = ["English", "Arabic", "French"];
  List<String> knownTopicsOptions = ["Tajweed", "Recitation", "Grammar"];
  List<String> focusAreasOptions = ["Pronunciation", "Fluency", "Memorization"];

  void setProficiencyLevel(String level) {
    _selectedProficiencyLevel = level;
    notifyListeners();
  }

  void setLearningStyle(String style) {
    _selectedLearningStyle = style;
    notifyListeners();
  }

  void setArabicLevel(String level) {
    _selectedArabicLevel = level;
    notifyListeners();
  }

  void setAcademicLevel(String level) {
    _selectedAcademicLevel = level;
    notifyListeners();
  }

  void setShariaLevel(String level) {
    _selectedShariaLevel = level;
    notifyListeners();
  }

  void setLessonLanguage(String language) {
    _selectedLessonLanguage = language;
    notifyListeners();
  }

  void toggleKnownTopic(String topic) {
    if (_selectedKnownTopics.contains(topic)) {
      _selectedKnownTopics.remove(topic);
    } else {
      _selectedKnownTopics.add(topic);
    }
    notifyListeners();
  }

  void toggleFocusArea(String area) {
    if (_selectedFocusAreas.contains(area)) {
      _selectedFocusAreas.remove(area);
    } else {
      _selectedFocusAreas.add(area);
    }
    notifyListeners();
  }

  void setGoals(Map<String, dynamic> goalsData) {
    _selectedProficiencyLevel = goalsData["proficiency_level"];
    _selectedLearningStyle = goalsData["learning_style"];
    _selectedArabicLevel = goalsData["arabic_level"];
    _selectedAcademicLevel = goalsData["academic_level"];
    _selectedShariaLevel = goalsData["sharia_study_level"];
    _selectedLessonLanguage = goalsData["lessons_language"];
    _selectedKnownTopics = List<String>.from(goalsData["known_topics"]);
    _selectedFocusAreas = List<String>.from(goalsData["focus_areas"]);
    notifyListeners();
  }
}
