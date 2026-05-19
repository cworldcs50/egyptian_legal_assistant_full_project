import 'ai_message.dart';
import 'user_message.dart';
import 'package:flutter/material.dart';
import '../../../chatbot/models/chat_message_model.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.role == MessageRole.user) {
      return UserMessage(message: message);
    }
    return AiMessage(message: message);
  }
}
