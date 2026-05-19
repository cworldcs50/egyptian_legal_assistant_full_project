import 'package:get_it/get_it.dart';
// import '../../features/onboarding/bloc/onboarding_bloc.dart';
import '../network/api_client.dart';
import '../network/network_info.dart';
import 'package:http/http.dart' as http;
import '../theme/cubit/theme_cubit.dart';
import '../services/firebase_services.dart';
import '../network/network_call_handler.dart';
import '../../features/home/home/bloc/home_bloc.dart';
import '../../features/sources/bloc/sources_bloc.dart';
import '../../features/settings/bloc/settings_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/sign_up/bloc/sign_up_bloc.dart';
import '../../features/auth/sign_in/bloc/sign_in_bloc.dart';
import '../../features/history/bloc/history_bloc.dart';
import '../../features/history/repository/i_history_repository.dart';
import '../../features/history/repository/history_repository_impl.dart';
import '../database/chat_history_db.dart';
import '../../features/auth/repository/i_auth_repository.dart';
import '../../features/auth/repository/auth_repository_impl.dart';
import '../../features/home/chatbot/repository/i_chatbot_repository.dart';
import '../../features/home/chatbot/repository/chatbot_repository_impl.dart';
import '../../features/auth/forget_password/bloc/forget_password_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../features/auth/repository/remote/i_auth_remote_data_source.dart';
import '../../features/auth/repository/remote/auth_remote_data_source_impl.dart';
import '../../features/settings/repository/repository/i_settings_repository.dart';
import '../../features/home/chatbot/repository/remote/i_chatbot_remote_data_source.dart';
import '../../features/settings/repository/remote/settings_remote_data_source.dart';
import '../../features/settings/repository/repository/settings_repository_impl.dart';
import '../../features/sources/repository/datasource/remote/sources_data_source.dart';
import '../../features/settings/repository/remote/i_settings_remote_data_source.dart';
import '../../features/home/chatbot/repository/remote/chatbot_remote_data_source_impl.dart';
import '../../features/sources/repository/datasource/repository/i_sources_repository.dart';
import '../../features/sources/repository/datasource/repository/sources_repository_impl.dart';
import '../../features/sources/repository/datasource/remote/i_base_sources_remote_data_source.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  sl.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );

  // Core
  sl.registerLazySingleton<ChatHistoryDatabase>(
    () => ChatHistoryDatabase.instance,
  );
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<ApiClient>(() => AppHttpApiClient(client: sl()));
  sl.registerLazySingleton<NetworkCallHandler>(
    () => NetworkCallHandler(networkInfo: sl()),
  );

  // Features - Sources
  sl.registerLazySingleton<ISourcesRemoteDataSource>(
    () => SourcesDataSource(networkCallHandler: sl()),
  );
  sl.registerLazySingleton<ISourcesRepository>(
    () => SourcesRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerFactory(() => SourcesBloc(iSourcesRepository: sl()));

  // Features - Auth
  sl.registerLazySingleton<FirebaseService>(() => FirebaseService());
  sl.registerLazySingleton<IAuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseService: sl()),
  );
  sl.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerFactory(() => SignInBloc(iAuthRepository: sl()));
  sl.registerFactory(() => SignUpBloc(iAuthRepository: sl()));
  sl.registerFactory(() => ForgetPasswordBloc(iAuthRepository: sl()));

  // Features - Chatbot
  sl.registerLazySingleton<IChatbotRemoteDataSource>(
    () =>
        ChatbotRemoteDataSourceImpl(apiClient: sl(), networkCallHandler: sl()),
  );
  sl.registerLazySingleton<IChatbotRepository>(
    () => ChatbotRepositoryImpl(remoteDataSource: sl()),
  );

  // Features - Home
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(iChatbotRepository: sl(), iAuthRepository: sl()),
  );

  // Features - Settings
  sl.registerLazySingleton<ISettingsRemoteDataSource>(
    () => SettingsRemoteDataSource(networkCallHandler: sl()),
  );
  sl.registerLazySingleton<ISettingsRepository>(
    () => SettingsRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory(() => SettingsBloc(iSettingsRepository: sl()));
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  // sl.registerLazySingleton<OnboardingBloc>(() => OnboardingBloc());

  // Features - History
  sl.registerLazySingleton<IHistoryRepository>(
    () => HistoryRepositoryImpl(db: sl()),
  );
  sl.registerLazySingleton<HistoryBloc>(
    () => HistoryBloc(iHistoryRepository: sl()),
  );
}
