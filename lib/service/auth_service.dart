import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>?> login(String username, String password) async {
    final url =
        Uri.parse('https://my-django-app-latest-ht9a.onrender.com/api/token/');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );
      print("Error: ${response.body}");
      print("Error: ${response.statusCode}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Auth failed: ${response.body}");
      }
    } catch (e) {
      print("AuthService error: $e");
    }
    return null;
  }
}
