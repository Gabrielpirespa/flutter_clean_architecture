part of 'fetch_apods_bloc.dart';

abstract class FetchApodsState extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchApodsInitial extends FetchApodsState {}

class LoadingFetchApodsState extends FetchApodsState {}

class ErrorFetchApodsState extends FetchApodsState {
  final String msg;

  ErrorFetchApodsState({required this.msg});

  @override
  List<Object> get props => [msg];
}

class SuccesListFetchApods extends FetchApodsState {
  final List<ApodEntity> list;

  SuccesListFetchApods({required this.list});

  @override
  List<Object> get props => [list];
}
