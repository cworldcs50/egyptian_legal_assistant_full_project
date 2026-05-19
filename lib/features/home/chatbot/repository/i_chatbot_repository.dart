import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';

abstract class IChatbotRepository {
  const IChatbotRepository();

  Stream<Either<Failure, String>> askQuestionStream(String question, String sessionId);
  Future<bool> getServerStatus();
}
