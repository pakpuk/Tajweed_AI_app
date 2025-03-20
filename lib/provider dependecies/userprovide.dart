import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userName = 'User';

  String get userName => _userName;

  void updateUserName(String newName) {
    _userName = newName;
    notifyListeners();
  }
}
