import 'package:flutter/material.dart';
import 'package:quran_app/service/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _accessToken;
  String? _errorMessage;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get accessToken => _accessToken;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final Map<String, dynamic>? response =
          await _authService.login(username, password);

      print("🔄 API Response: $response");

      if (response != null && response.containsKey('access')) {
        _accessToken = response['access'];
        _isAuthenticated = true;
        _isLoading = false;
        notifyListeners();
        print("✅ Login successful! Token: $_accessToken");
        return true;
      } else {
        _errorMessage = "Invalid username or password.";
        print("❌ Login failed: No access token found.");
      }
    } catch (e) {
      _errorMessage = "Network error: ${e.toString()}";
      print("🚨 Login error: $_errorMessage");
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  void logout() {
    _isAuthenticated = false;
    _accessToken = null;
    _errorMessage = null;
    notifyListeners();
    print("🚪 Logged out.");
  }
}
