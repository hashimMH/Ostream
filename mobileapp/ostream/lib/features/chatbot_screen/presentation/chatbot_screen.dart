import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:ostream/utils/resources/app_assets.dart';
import 'package:ostream/utils/resources/app_fonts.dart';
import 'package:ostream/utils/resources/constants.dart';
import 'package:uuid/uuid.dart';

import 'controller/cubit/chatbot_cubit.dart';
import 'controller/cubit/chatbot_state.dart';

class ChatBotScreen extends StatelessWidget {
  static const routeName = '/ChatBotScreen';

  const ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppAssets.logo, height: 45),
      ),
      body: BlocProvider(
        create: (_) => ChatbotCubit()..initializeChat(),
        child: BlocBuilder<ChatbotCubit, ChatbotState>(
          builder: (context, state) {
            final cubit = ChatbotCubit.get(context);

            return Column(
              children: [
                Expanded(
                  child: Chat(
                    showUserAvatars: true,
                    showUserNames: true,
                    avatarBuilder: (_) => Padding(
                      padding: const EdgeInsetsDirectional.only(end: 10),
                      child: Image.asset(AppAssets.logo, height: 45),
                    ),
                    emptyState: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("ASK OUR AI", style: AppFonts.hBig),
                        const SizedBox(height: AppConstants.spaceBetween),
                        Image.asset(AppAssets.logo, height: 60),
                        const SizedBox(height: AppConstants.spaceBetween),
                        Image.asset(AppAssets.logoWord, height: 60),
                      ],
                    ),
                    messages: cubit.messages,
                    onMessageTap: (context, message) {
                      cubit.handleMessageTap(message);
                    },
                    user: cubit.user,
                    onSendPressed: (partialText) {
                      cubit.handleSendPressed(partialText.text);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
