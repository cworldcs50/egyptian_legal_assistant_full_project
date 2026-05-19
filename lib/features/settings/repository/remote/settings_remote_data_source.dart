import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/network_call_handler.dart';
import 'i_settings_remote_data_source.dart';

class SettingsRemoteDataSource implements ISettingsRemoteDataSource {
  final NetworkCallHandler networkCallHandler;

  SettingsRemoteDataSource({required this.networkCallHandler});

  @override
  Future<Either<Failure, void>> clearConversations() async {
    // Placeholder for future API call to clear history on server
    return const Right(null);
  }
}
