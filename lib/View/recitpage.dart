import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_app/View/recit_page_result.dart';
import 'package:quran_app/provider%20dependecies/recite_provider.dart';

class RecitePage extends StatelessWidget {
  const RecitePage({super.key});

  @override
  Widget build(BuildContext context) {
    final reciteProvider = Provider.of<ReciteProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Retain Quran: Random Test",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Start reciting and receive instant AI feedback!",
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: reciteProvider.selectedSurah,
                    items: ["Al-Kahf", "Al-Baqara", "Yasin"].map((surah) {
                      return DropdownMenuItem(
                        value: surah,
                        child: Text(surah,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        reciteProvider.setSurah(value);
                      }
                    },
                    isExpanded: true,
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.green),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              TextField(
                decoration: InputDecoration(
                  labelText: "Select Verses (e.g., 1-5)",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                ),
                textAlign: TextAlign.center,
                onChanged: (value) => reciteProvider.setVerses(value),
              ),
              SizedBox(height: 20.h),
              IconButton(
                onPressed: () async {
                  await reciteProvider.analyzeRecitation();
                },
                icon: const Icon(Icons.mic, color: Colors.green, size: 50),
              ),
              SizedBox(height: 20.h),
              if (reciteProvider.aiFeedback.isNotEmpty)
                Column(
                  children: [
                    const Text("AI Feedback:",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                    SizedBox(height: 10.h),
                    Text(
                      reciteProvider.aiFeedback["mistakes"] ??
                          "No mistakes detected",
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  reciteProvider.analyzeRecitation();
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReciteResultPage()),
                    );
                  });
                },
                child: Text("Click to see your score"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
