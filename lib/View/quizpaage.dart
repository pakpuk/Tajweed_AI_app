import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/provider%20dependecies/quiz_type_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import for screenutil

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  List<dynamic> _questions = [];
  bool _showFeedback = false;
  String _feedbackMessage = '';
  Color _feedbackColor = Colors.transparent;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    Future.delayed(Duration.zero, () {
      final quizProvider =
          Provider.of<QuizTypeProvider>(context, listen: false);
      setState(() {
        _questions = quizProvider.questions;
      });
      _loadProgress();
      _controller.forward();
    });
  }

  void _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedIndex = prefs.getInt('quiz_progress') ?? 0;
    if (savedIndex < _questions.length) {
      setState(() {
        _currentIndex = savedIndex;
      });
    }
  }

  void _saveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('quiz_progress', _currentIndex);
  }

  void _onAnswerSelected(String selectedAnswer) {
    final correctAnswer = _questions[_currentIndex]['correct_answer'];
    setState(() {
      _showFeedback = true;
      if (selectedAnswer == correctAnswer) {
        _feedbackMessage = '✅ Correct!';
        _feedbackColor = Colors.green;
      } else {
        _feedbackMessage = '❌ Incorrect!';
        _feedbackColor = Colors.red;
      }
    });

    Future.delayed(Duration(seconds: 1), () {
      if (_currentIndex < _questions.length - 1) {
        setState(() {
          _currentIndex++;
          _showFeedback = false;
          _feedbackColor = Colors.transparent;
        });
        _controller.forward(from: 0.0);
        _saveProgress();
      } else {
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("🎉 Quiz Completed!"),
        content: Text("Congratulations! You've finished the quiz."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text("Back to Home"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final question = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz - ${Provider.of<QuizTypeProvider>(context).selectedCategory}',
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: (_currentIndex + 1) / _questions.length,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              SizedBox(height: 20.h),
              Text(
                "Question ${_currentIndex + 1} of ${_questions.length}",
                style:
                    GoogleFonts.lato(fontSize: 18.sp, color: Colors.grey[700]),
              ),
              SizedBox(height: 10.h),
              Text(
                question['question'],
                style: GoogleFonts.lato(
                    fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              Column(
                children: (question['options'] as List<String>).map((option) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => _onAnswerSelected(option),
                      child: Text(option, style: TextStyle(fontSize: 18.sp)),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.h),
              if (_showFeedback)
                Text(
                  _feedbackMessage,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: _feedbackColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
