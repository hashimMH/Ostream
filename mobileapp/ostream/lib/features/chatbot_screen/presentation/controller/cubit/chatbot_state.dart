import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

abstract class ChatbotState {}

class ChatbotInitial extends ChatbotState {}

class ChatbotLoaded extends ChatbotState {
  final List<types.Message> messages;

  ChatbotLoaded({required this.messages});
}
