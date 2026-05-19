import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/network_call_handler.dart';
import '../../../../../core/constants/app_links.dart';
import 'i_chatbot_remote_data_source.dart';

class ChatbotRemoteDataSourceImpl implements IChatbotRemoteDataSource {
  final ApiClient apiClient;
  final NetworkCallHandler networkCallHandler;

  const ChatbotRemoteDataSourceImpl({
    required this.apiClient,
    required this.networkCallHandler,
  });

  @override
  Stream<Either<Failure, String>> askQuestionStream(String question, String sessionId) {
    return networkCallHandler.callStream<String>(
      () => apiClient.streamPost(AppLinks.kAsk, body: {
        'question': question,
        'session_id': sessionId,
      }),
    );
  }

  @override
  Future<bool> checkStatus() async {
    try {
      final response = await apiClient.get(AppLinks.kStatus);
      return response == true || response['status'] == true;
    } catch (e) {
      return false;
    }
  }
}
