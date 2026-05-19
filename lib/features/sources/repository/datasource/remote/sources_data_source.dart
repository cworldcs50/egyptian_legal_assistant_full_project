import 'package:fpdart/fpdart.dart';
import '../../models/legal_source_model.dart';
import '../../../../../core/error/failure.dart';
import 'i_base_sources_remote_data_source.dart';
import '../../../../../core/network/network_call_handler.dart';

class SourcesDataSource implements ISourcesRemoteDataSource {
  final NetworkCallHandler networkCallHandler;

  const SourcesDataSource({required this.networkCallHandler});

  @override
  Future<Either<Failure, List<LegalSourceModel>>> call(
    Future<List<LegalSourceModel>> Function() action,
  ) async => await networkCallHandler(action);
}
