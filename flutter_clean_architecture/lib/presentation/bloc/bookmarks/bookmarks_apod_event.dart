part of 'bookmarks_apod_bloc.dart';

abstract class BookmarksApodEvent extends Equatable {
  const BookmarksApodEvent();

  @override
  List<Object> get props => [];
}

class IsApodSavedEvent extends BookmarksApodEvent {
  final String date;

  const IsApodSavedEvent({required this.date});

  @override
  List<Object> get props => [date];
}

class FetchAllSavedApodsEvent extends BookmarksApodEvent {}
