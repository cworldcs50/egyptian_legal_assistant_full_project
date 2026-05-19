import 'sources_states.dart';
import 'sources_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/datasource/repository/i_sources_repository.dart';
import '../../../core/constants/app_links.dart';
import '../repository/models/legal_source_model.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/network/api_client.dart';

class SourcesBloc extends Bloc<BaseSourcesEvent, BaseSourcesState> {
  SourcesBloc({required this.iSourcesRepository})
    : super(const LoadingSourcesState()) {
    on<GetSourcesEvent>(_getSourcesEvent);
  }

  final ISourcesRepository iSourcesRepository;

  Future<void> _getSourcesEvent(
    GetSourcesEvent event,
    Emitter<BaseSourcesState> emit,
  ) async {
    emit(const LoadingSourcesState());

    // This is how you work "truly" with the network module:
    // 1. You pass the API call (the "action") to the repository.
    // 2. The repository wraps it with NetworkCallHandler for safety.
    final result = await iSourcesRepository(() async {
      final List response = await sl<ApiClient>().get(AppLinks.kSources);
      return response.map((json) => LegalSourceModel.fromJson(json)).toList();
    });

    result.fold(
      (failure) => emit(FailureSourcesState(failure: failure)),
      (success) => emit(SuccessSourcesState(legalSources: success)),
    );
  }
}
