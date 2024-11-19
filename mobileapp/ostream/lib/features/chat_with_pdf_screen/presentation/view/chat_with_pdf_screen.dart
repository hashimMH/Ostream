import 'package:flutter/material.dart';

class ChatPDFScreen extends StatefulWidget {
  @override
  _ChatPDFScreenState createState() => _ChatPDFScreenState();
}

class _ChatPDFScreenState extends State<ChatPDFScreen> {
  String? fileId;
  String? answer;
  bool isUploading = false;
  bool isAsking = false;

  final String apiKey = 'sec_i6vFQtLLf1KavX0n2BS7qx9NtwRFTTc8';
  final TextEditingController questionController = TextEditingController();

  Future<void> handleFileUpload() async {
    setState(() {
      isUploading = true;
    });
    final file = await pickPDFFile();
    if (file != null) {
      final id = await uploadPDF(file.path!, apiKey);
      setState(() {
        fileId = id;
      });
    }
    setState(() {
      isUploading = false;
    });
  }

  Future<void> handleAskQuestion(String question) async {
    if (fileId != null) {
      setState(() {
        isAsking = true;
      });
      final response = await askQuestion(fileId!, question, apiKey);
      setState(() {
        answer = response;
        isAsking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with PDF'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Upload Button
              ElevatedButton.icon(
                onPressed: isUploading ? null : handleFileUpload,
                icon: isUploading
                    ? const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                )
                    : const Icon(Icons.upload_file),
                label: const Text('Upload PDF'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (fileId != null) ...[
                // Question Input
                TextField(
                  controller: questionController,
                  decoration: InputDecoration(
                    labelText: 'Ask a Question',
                    hintText: 'Type your question here',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: const Icon(Icons.question_answer),
                  ),
                ),
                const SizedBox(height: 16),
                // Ask Button
                ElevatedButton(
                  onPressed: isAsking
                      ? null
                      : () => handleAskQuestion(questionController.text),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isAsking
                      ? const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  )
                      : const Text('Ask'),
                ),
                const SizedBox(height: 20),
              ],
              // Display Answer
              if (answer != null)
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Answer: $answer',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              const Text(
                'This feature is available in the full version.',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Mock functions for demonstration
  Future<PickedFile?> pickPDFFile() async {
    // Replace with actual file picker logic
    await Future.delayed(const Duration(seconds: 1));
    return PickedFile('path/to/file.pdf');
  }

  Future<String> uploadPDF(String filePath, String apiKey) async {
    // Replace with actual upload logic
    await Future.delayed(const Duration(seconds: 1));
    return 'mock-file-id';
  }

  Future<String> askQuestion(String fileId, String question, String apiKey) async {
    // Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    return 'Mock Answer for "$question"';
  }
}

class PickedFile {
  final String path;
  PickedFile(this.path);
}
