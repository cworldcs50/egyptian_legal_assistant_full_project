import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import 'i_chatbot_repository.dart';
import 'remote/i_chatbot_remote_data_source.dart';

class ChatbotRepositoryImpl implements IChatbotRepository {
  final IChatbotRemoteDataSource remoteDataSource;

  const ChatbotRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Either<Failure, String>> askQuestionStream(String question, String sessionId) {
    return remoteDataSource.askQuestionStream(question, sessionId);
  }

  @override
  Future<bool> getServerStatus() async {
    return await remoteDataSource.checkStatus();
  }
}
