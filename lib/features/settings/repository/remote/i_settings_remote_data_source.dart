import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';

abstract class ISettingsRemoteDataSource {
  Future<Either<Failure, void>> clearConversations();
}
