import 'package:fpdart/fpdart.dart';
import '../../models/legal_source_model.dart';
import '../../../../../../core/error/failure.dart';

abstract class ISourcesRepository {
  const ISourcesRepository();
  Future<Either<Failure, List<LegalSourceModel>>> call(
    Future<List<LegalSourceModel>> Function() action,
  );
}
