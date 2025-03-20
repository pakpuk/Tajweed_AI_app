import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message.dart';

class ChatService {
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  static Future<List<Message>> fetchMessages() async {
    final response = await http.get(Uri.parse('$_baseUrl/messages/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  static Future<void> sendMessage(String sender, String text) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/messages/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'sender': sender, 'text': text}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to send message');
    }
  }
}
