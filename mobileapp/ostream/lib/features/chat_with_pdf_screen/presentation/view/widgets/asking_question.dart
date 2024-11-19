import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String?> askQuestion(String fileId, String question, String apiKey) async {
  final url = Uri.parse('https://api.chatpdf.com/v1/ask');
  final body = jsonEncode({'fileId': fileId, 'question': question});

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: body,
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['answer']; // Assuming the API returns an answer
  } else {
    print('Error: ${response.statusCode}');
  }
  return null;
}
