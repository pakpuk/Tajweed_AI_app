import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final String baseUrl = "http://my-django-app-latest-ht9a.onrender.com/i";

  final _storage = const FlutterSecureStorage();

  Future<String?> getApiKey() async {
    return await _storage.read(key: "api_key");
  }

  Future<bool> setGoals(Map<String, dynamic> goalsData) async {
    final apiKey = await getApiKey();
    final response = await http.post(
      Uri.parse("$baseUrl/set-goals/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
      body: jsonEncode(goalsData),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print("Error: ${response.body}");
      return false;
    }
  }

  Future<Map<String, dynamic>?> getGoals() async {
    final apiKey = await getApiKey();
    final response = await http.get(
      Uri.parse("$baseUrl/get-goals/"),
      headers: {
        "Authorization": "Bearer $apiKey",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error: ${response.body}");
      return null;
    }
  }
}
