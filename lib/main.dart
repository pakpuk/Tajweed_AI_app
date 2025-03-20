import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/View/Get_started.dart';
import 'package:quran_app/View/Learnpaage.dart';
import 'package:quran_app/View/Quizresult.dart';
import 'package:quran_app/View/account_view.dart';
import 'package:quran_app/View/chatpage.dart';
import 'package:quran_app/View/homepaage.dart';
import 'package:quran_app/View/quizSelctiontyper.dart';
import 'package:quran_app/View/quizpaage.dart';
import 'package:quran_app/View/recitpage.dart';
import 'package:quran_app/View/setgoals.dart';
import 'package:quran_app/authentification/Signin.dart';
import 'package:quran_app/provider%20dependecies/auth_provider.dart';
import 'package:quran_app/provider%20dependecies/learning_plan_provider.dart';
import 'package:quran_app/provider%20dependecies/progress_provider.dart';
import 'package:quran_app/provider%20dependecies/quiz_type_provider.dart';
import 'package:quran_app/provider%20dependecies/leaarn_provider.dart';
import 'package:quran_app/provider%20dependecies/recite_provider.dart';
import 'package:quran_app/provider%20dependecies/userprovide.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LearnProvider()),
        ChangeNotifierProvider(create: (_) => QuizTypeProvider()),
        ChangeNotifierProvider(create: (_) => ReciteProvider()),
        ChangeNotifierProvider(create: (_) => LearningPlanProvider()),
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tajweed AI',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SignInView(),
          '/getstarted': (context) => GetStartedPage(),
          '/home': (context) => HomePage(),
          '/recite': (context) => RecitePage(),
          '/learn': (context) => LearnPage(),
          '/quiz': (context) => QuizPage(),
          '/chat': (context) => ChatPage(),
          '/account': (context) => AccountView(),
          '/quiztype': (context) => QuizSelectionPage(),
          '/quizresult': (context) => QuizResultsPage(),
          '/setgoals': (context) => SetGoalsPage(),
        });
  }
}
