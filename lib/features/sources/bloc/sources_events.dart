import 'package:equatable/equatable.dart';

class BaseSourcesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSourcesEvent extends BaseSourcesEvent {}

class RefreshSourcesEvent extends BaseSourcesEvent {}
