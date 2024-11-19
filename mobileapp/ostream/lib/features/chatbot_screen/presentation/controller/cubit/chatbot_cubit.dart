import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:google_gemini/google_gemini.dart';
import 'package:ostream/utils/di/injection.dart';
import 'package:ostream/utils/network/connection/network_info.dart';
import 'package:uuid/uuid.dart';
import '../../../../../env.dart';
import 'chatbot_state.dart';

class ChatbotCubit extends Cubit<ChatbotState> {
  ChatbotCubit() : super(ChatbotInitial());

  static ChatbotCubit get(context) => BlocProvider.of(context);


  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  final gemini = GoogleGemini(
    apiKey: Env.geminiKey,
  );
  List<types.Message> get messages => List.unmodifiable(_messages);

  types.User get user => _user;

  void initializeChat() {
    emit(ChatbotLoaded(messages: _messages));
  }

  void handleSendPressed(String text) {
    if (text.isEmpty) return;

    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: text,
    );

    _addMessage(textMessage);

    // Call the bot response logic
    _simulateBotResponse(text);
  }

  void _simulateBotResponse(String query) async {
    // Add a temporary "typing..." message
    final typingMessage = types.TextMessage(
      author: const types.User(id: 'bot', firstName: 'AI Bot'),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: 'Typing...',
    );

    _addMessage(typingMessage);

    // Simulate a delay for bot response
    try {
      final response = await gemini.generateFromText(query);

      // Remove the "typing..." message
      _removeMessage(typingMessage);

      // Add the actual bot response
      final botMessage = types.TextMessage(
        author: const types.User(id: 'bot', firstName: 'AI Bot'),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: response.text,
      );

      _addMessage(botMessage);
    } catch (error) {
      // Remove the "typing..." message
      _removeMessage(typingMessage);
      // Add an error message
      final botMessage = types.TextMessage(
        author: const types.User(id: 'bot', firstName: 'AI Bot'),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "Please, try again later. Connection error: $error",
      );

      _addMessage(botMessage);
    }
  }
  void handleMessageTap(types.Message message) {
    if (message is types.FileMessage) {
      // Implement file handling logic here
    }
  }

  void _addMessage(types.Message message) {
    _messages.insert(0, message);
    emit(ChatbotLoaded(messages: _messages));
  }

  void _removeMessage(types.Message message) {
    _messages.remove(message);
    emit(ChatbotLoaded(messages: _messages));
  }
}
