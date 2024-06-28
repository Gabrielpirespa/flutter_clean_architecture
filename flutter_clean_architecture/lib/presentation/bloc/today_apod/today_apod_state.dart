part of 'today_apod_bloc.dart';

abstract class TodayApodState extends Equatable {
  const TodayApodState();

  @override
  List<Object?> get props => [];
}

// success case
class SuccesTodayApodState extends TodayApodState {
  final ApodEntity apod;

  const SuccesTodayApodState({required this.apod});

  @override
  List<Object?> get props => [apod];
}

// error case
class ErrorTodayApodState extends TodayApodState {
  final String message;

  const ErrorTodayApodState({required this.message});

  @override
  List<Object?> get props => [message];
}

// loading
class LoadingTodayApodState extends TodayApodState {}
