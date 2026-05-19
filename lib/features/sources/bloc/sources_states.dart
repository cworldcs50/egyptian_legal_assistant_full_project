import 'package:equatable/equatable.dart';

import '../../../core/error/failure.dart';
import '../repository/models/legal_source_model.dart';

sealed class BaseSourcesState extends Equatable {
  const BaseSourcesState();

  @override
  List<Object?> get props => [];
}

class LoadingSourcesState extends BaseSourcesState {
  const LoadingSourcesState();
}

class SuccessSourcesState extends BaseSourcesState {
  const SuccessSourcesState({required this.legalSources});

  final List<LegalSourceModel> legalSources;

  @override
  List<Object?> get props => [legalSources];
}

class FailureSourcesState extends BaseSourcesState {
  const FailureSourcesState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
