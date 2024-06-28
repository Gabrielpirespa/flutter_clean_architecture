part of 'today_apod_bloc.dart';

//Cria uma classe abstrata de evento para poder utilizar múltiplas herdeiras da mesma

abstract class TodayApodEvent extends Equatable {
  const TodayApodEvent();

  @override
  List<Object?> get props => [];
}

class FetchApodTodayEvent extends TodayApodEvent {}
