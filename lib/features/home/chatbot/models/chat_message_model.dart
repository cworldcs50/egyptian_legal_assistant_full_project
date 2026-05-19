import 'citation_model.dart';
import 'package:equatable/equatable.dart';

enum MessageRole { user, assistant }

class ChatMessage extends Equatable {
  final String id;
  final String message;
  final MessageRole role;
  final DateTime timestamp;
  final List<Citation>? citations;

  const ChatMessage({
    this.citations,
    required this.id,
    required this.role,
    required this.message,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, message, role, timestamp, citations];

  ChatMessage copyWith({
    String? id,
    String? message,
    MessageRole? role,
    List<Citation>? citations,
    DateTime? timestamp,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      role: role ?? this.role,
      message: message ?? this.message,
      citations: citations ?? this.citations,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
