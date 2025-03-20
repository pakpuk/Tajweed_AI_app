import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:quran_app/provider%20dependecies/leaarn_provider.dart';

import 'package:quran_app/provider%20dependecies/progress_provider.dart';

class LearnPage extends StatefulWidget {
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  @override
  void initState() {
    super.initState();
    final learnProvider = Provider.of<LearnProvider>(context, listen: false);
    learnProvider.generateLessonContent(learnProvider.currentLessonTitle);
  }

  @override
  Widget build(BuildContext context) {
    final learnProvider = Provider.of<LearnProvider>(context);
    final progressProvider = Provider.of<ProgressProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Learn Tajweed")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Progress: ${progressProvider.completedLessons.length} / ${learnProvider.totalLessons} lessons completed",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              learnProvider.currentLessonTitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: learnProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Markdown(data: learnProvider.markdownContent),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: learnProvider.currentLessonIndex > 0
                      ? () => learnProvider.previousLesson()
                      : null,
                  child: Text("Previous Lesson"),
                ),
                ElevatedButton(
                  onPressed: () {
                    progressProvider
                        .markLessonCompleted(learnProvider.currentLessonTitle);
                    learnProvider.nextLesson();
                  },
                  child: Text(
                    progressProvider
                            .isLessonCompleted(learnProvider.currentLessonTitle)
                        ? "Completed"
                        : "Next Lesson",
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: progressProvider
                            .isLessonCompleted(learnProvider.currentLessonTitle)
                        ? Colors.green
                        : Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
