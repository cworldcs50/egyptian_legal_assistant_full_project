import 'i_sources_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../models/legal_source_model.dart';
import '../../../../../../core/error/failure.dart';
import '../remote/i_base_sources_remote_data_source.dart';

class SourcesRepositoryImpl implements ISourcesRepository {
  final ISourcesRemoteDataSource remoteDataSource;

  const SourcesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<LegalSourceModel>>> call(
    Future<List<LegalSourceModel>> Function() action,
  ) async => await remoteDataSource(action);
}
