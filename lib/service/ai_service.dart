import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const String _apiKey =
      'your_openai_api_key'; // Replace with your OpenAI API key
  static const String _apiUrl = 'https://api.openai.com/v1/completions';

  // Function to generate lesson content using OpenAI
  static Future<String> generateLessonContent(String lesson) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: json.encode({
        'model': 'text-davinci-003',
        'prompt': 'Explain the Tajweed rule "$lesson" in detail with examples.',
        'max_tokens': 500,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['choices'][0]['text'].trim();
    } else {
      throw Exception('Failed to generate content: ${response.body}');
    }
  }

  // Function to generate AI-based quiz questions
  static Future<List<Map<String, dynamic>>> generateQuiz(String topic) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: json.encode({
        'model': 'text-davinci-003',
        'prompt':
            'Generate a 3-question multiple-choice quiz on "$topic". Provide JSON format: [{"question": "", "options": ["", "", "", ""], "correct_answer": ""}]',
        'max_tokens': 500,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(
          json.decode(data['choices'][0]['text']));
    } else {
      throw Exception('Failed to generate quiz: ${response.body}');
    }
  }
}
