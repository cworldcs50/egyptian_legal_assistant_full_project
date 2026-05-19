import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';

abstract class IChatbotRemoteDataSource {
  const IChatbotRemoteDataSource();

  Stream<Either<Failure, String>> askQuestionStream(String question, String sessionId);
  Future<bool> checkStatus();
}
