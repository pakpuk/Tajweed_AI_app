import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/View/Learnpaage.dart';
import 'package:quran_app/provider%20dependecies/leaarn_provider.dart';
import 'package:quran_app/provider%20dependecies/learning_plan_provider.dart';
import 'package:quran_app/service/api_service.dart';

class SetGoalsPage extends StatefulWidget {
  @override
  _SetGoalsPageState createState() => _SetGoalsPageState();
}

class _SetGoalsPageState extends State<SetGoalsPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController goalsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final learningPlanProvider = Provider.of<LearningPlanProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Set Your Learning Goals")),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdown(
                    "Proficiency Level",
                    learningPlanProvider.proficiencyLevels,
                    learningPlanProvider.selectedProficiencyLevel,
                    (value) =>
                        learningPlanProvider.setProficiencyLevel(value!)),
                _buildDropdown(
                    "Learning Style",
                    learningPlanProvider.learningStyles,
                    learningPlanProvider.selectedLearningStyle,
                    (value) => learningPlanProvider.setLearningStyle(value!)),
                _buildDropdown(
                    "Arabic Level",
                    learningPlanProvider.arabicLevels,
                    learningPlanProvider.selectedArabicLevel,
                    (value) => learningPlanProvider.setArabicLevel(value!)),
                _buildDropdown(
                    "Academic Level",
                    learningPlanProvider.academicLevels,
                    learningPlanProvider.selectedAcademicLevel,
                    (value) => learningPlanProvider.setAcademicLevel(value!)),
                _buildDropdown(
                    "Sharia Study Level",
                    learningPlanProvider.shariaLevels,
                    learningPlanProvider.selectedShariaLevel,
                    (value) => learningPlanProvider.setShariaLevel(value!)),
                _buildDropdown(
                    "Lessons Language",
                    learningPlanProvider.lessonLanguages,
                    learningPlanProvider.selectedLessonLanguage,
                    (value) => learningPlanProvider.setLessonLanguage(value!)),
                _buildChips(
                    "Known Topics",
                    learningPlanProvider.knownTopicsOptions,
                    learningPlanProvider.selectedKnownTopics,
                    learningPlanProvider.toggleKnownTopic),
                _buildChips(
                    "Focus Areas",
                    learningPlanProvider.focusAreasOptions,
                    learningPlanProvider.selectedFocusAreas,
                    learningPlanProvider.toggleFocusArea),
                TextFormField(
                  controller: goalsController,
                  decoration: InputDecoration(labelText: "Your Goals"),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter your goals' : null,
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: _submitGoals,
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? selectedValue,
      Function(String?) onChanged) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: DropdownButtonFormField<String>(
        value: (selectedValue != null && items.contains(selectedValue))
            ? selectedValue
            : (items.isNotEmpty ? items.first : null),
        decoration: InputDecoration(labelText: label),
        items: items.toSet().map((item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildChips(String label, List<String> options,
      List<String> selectedList, Function(String) toggleSelection) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8.w,
          children: options.map((option) {
            final isSelected = selectedList.contains(option);
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (selected) => setState(() => toggleSelection(option)),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _submitGoals() async {
    if (_formKey.currentState!.validate()) {
      final learningPlanProvider =
          Provider.of<LearningPlanProvider>(context, listen: false);

      final goalsData = {
        "proficiency_level": learningPlanProvider.selectedProficiencyLevel,
        "learning_style": learningPlanProvider.selectedLearningStyle,
        "arabic_level": learningPlanProvider.selectedArabicLevel,
        "academic_level": learningPlanProvider.selectedAcademicLevel,
        "sharia_study_level": learningPlanProvider.selectedShariaLevel,
        "lessons_language": learningPlanProvider.selectedLessonLanguage,
        "known_topics": learningPlanProvider.selectedKnownTopics,
        "focus_areas": learningPlanProvider.selectedFocusAreas,
        "goals": goalsController.text,
      };

      bool success = await ApiService().setGoals(goalsData);

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LearnPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save goals. Try again.")),
        );
      }
    }
  }
}
