import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/provider%20dependecies/recite_provider.dart';

class ReciteResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reciteProvider = Provider.of<ReciteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Recitation Result", style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Surah: ${reciteProvider.selectedSurah}",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Text(
                "Verses: ${reciteProvider.selectedVerses}",
                style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h),
              reciteProvider.aiFeedback.isEmpty
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        Text(
                          "Mistakes:",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          reciteProvider.aiFeedback["mistakes"] ??
                              "No mistakes detected",
                          style: TextStyle(fontSize: 16.sp, color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "Suggestions:",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          reciteProvider.aiFeedback["suggestions"] ??
                              "Great job! Keep practicing.",
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.green),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
              SizedBox(height: 40.h),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child:
                    Text("Back to Recite", style: TextStyle(fontSize: 16.sp)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
