import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/provider%20dependecies/quiz_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import for screenutil

class QuizResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final int score = quizProvider.score;
    final int total = quizProvider.totalQuestions;

    String getPerformanceMessage() {
      double percentage = (score / total) * 100;
      if (percentage >= 80) return "🌟 Excellent Job!";
      if (percentage >= 50) return "👍 Good effort, keep going!";
      return "💡 Don't worry, try again!";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getPerformanceMessage(),
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: score),
                duration: Duration(seconds: 2),
                builder: (context, value, child) {
                  return Text(
                    'Your Score: $value/$total',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  );
                },
              ),
              SizedBox(height: 20.h),
              LinearProgressIndicator(
                value: score / total,
                backgroundColor: Colors.grey[300],
                color: Colors.green,
                minHeight: 10,
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  quizProvider.resetQuiz();
                  Navigator.popUntil(
                      context, ModalRoute.withName('/quizSelection'));
                },
                child: Text('🏠 Back to Quiz Selection'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () {
                  quizProvider.restartQuiz();
                  Navigator.pop(context);
                },
                child: Text('🔄 Retry Quiz'),
                style: ElevatedButton.styleFrom(
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
