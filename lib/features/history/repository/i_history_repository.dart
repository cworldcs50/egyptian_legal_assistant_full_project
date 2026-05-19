import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../home/chatbot/models/chat_message_model.dart';

abstract class IHistoryRepository {
  Future<Either<Failure, List<Map<String, dynamic>>>> getAllSessions();
  Future<Either<Failure, List<ChatMessage>>> getMessagesForSession(String sessionId);
  Future<Either<Failure, Unit>> deleteSession(String sessionId);
}
