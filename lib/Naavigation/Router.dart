import 'package:flutter/material.dart';
import 'package:quran_app/View/Get_started.dart';
import 'package:quran_app/View/Learnpaage.dart';
import 'package:quran_app/View/chatpage.dart';
import 'package:quran_app/View/homepaage.dart';
import 'package:quran_app/View/quizSelctiontyper.dart';
import 'package:quran_app/View/account_view.dart';
import 'package:quran_app/View/quizpaage.dart';
import 'package:quran_app/View/recitpage.dart';
import 'package:quran_app/View/setgoals.dart';
import 'package:quran_app/View/Quizresult.dart';
import 'package:quran_app/View/recit_page_result.dart';
import 'package:quran_app/authentification/Signin.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SignInView());
      case '/getStarted':
        return MaterialPageRoute(builder: (_) => GetStartedPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/recite':
        return MaterialPageRoute(builder: (_) => RecitePage());
      case '/learn':
        return MaterialPageRoute(builder: (_) => LearnPage());
      case '/quiztype':
        return MaterialPageRoute(builder: (_) => QuizSelectionPage());
      case '/account':
        return MaterialPageRoute(builder: (_) => AccountView());
      case '/setgoals':
        return MaterialPageRoute(builder: (_) => SetGoalsPage());
      case '/quizresult':
        return MaterialPageRoute(builder: (_) => QuizResultsPage());
      case '/recitresult':
        return MaterialPageRoute(builder: (_) => ReciteResultPage());
      case '/chat':
        return MaterialPageRoute(builder: (_) => ChatPage());
      case '/quiz':
        return MaterialPageRoute(builder: (_) => QuizPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text("Error 404")),
            body: const Center(
              child: Text('Page Not Found', style: TextStyle(fontSize: 18)),
            ),
          ),
        );
    }
  }
}
