import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/View/quizpaage.dart';
import 'package:animations/animations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/provider%20dependecies/quiz_type_provider.dart';

class QuizSelectionPage extends StatelessWidget {
  final List<String> categories = [
    'Quran & Tafsir',
    'Stories of Prophets',
    'Fiqh & Rules',
    'Islamic Stories'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose a Quiz Category")),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a Quiz Category',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return _buildQuizCategory(context, categories[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizCategory(BuildContext context, String category) {
    return OpenContainer(
      closedColor: Colors.green,
      closedElevation: 5,
      transitionType: ContainerTransitionType.fadeThrough,
      closedBuilder: (context, action) => ListTile(
        title: Text(
          category,
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.white),
        tileColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onTap: () {
          Provider.of<QuizTypeProvider>(context, listen: false)
              .selectCategory(category);
          action();
        },
      ),
      openBuilder: (context, action) => QuizPage(),
    );
  }
}
