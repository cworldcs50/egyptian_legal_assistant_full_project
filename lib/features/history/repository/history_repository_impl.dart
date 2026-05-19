import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/database/chat_history_db.dart';
import '../../home/chatbot/models/chat_message_model.dart';
import 'i_history_repository.dart';

class HistoryRepositoryImpl implements IHistoryRepository {
  final ChatHistoryDatabase db;

  HistoryRepositoryImpl({required this.db});

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getAllSessions() async {
    try {
      final sessions = await db.getAllSessions();
      return Right(sessions);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessage>>> getMessagesForSession(String sessionId) async {
    try {
      final messages = await db.getMessagesForSession(sessionId);
      return Right(messages);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteSession(String sessionId) async {
    try {
      await db.deleteSession(sessionId);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
