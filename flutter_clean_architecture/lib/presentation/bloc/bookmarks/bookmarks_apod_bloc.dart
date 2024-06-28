import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/domain/usecases/bookmarks/fetch_all_saved_apods.dart';
import 'package:flutter_clean_architecture/domain/usecases/bookmarks/is_apod_saved.dart';
import 'package:flutter_clean_architecture/domain/usecases/bookmarks/remove_saved_apod.dart';
import 'package:flutter_clean_architecture/domain/usecases/bookmarks/save_apod.dart';

part 'bookmarks_apod_event.dart';
part 'bookmarks_apod_state.dart';

class BookmarksApodBloc {
  IsApodSaved isApodSaved;
  FetchAllSavedApods fetchAllSavedApods;
  RemoveSavedApod removeSavedApod;
  SaveApod saveApod;

  BookmarksApodBloc(
      {required this.isApodSaved,
      required this.fetchAllSavedApods,
      required this.removeSavedApod,
      required this.saveApod}) {
    _inputController.stream.listen(_mapEventToState);
  }

  final StreamController<BookmarksApodEvent> _inputController =
      StreamController<BookmarksApodEvent>();
  final StreamController<BookmarksApodState> _outputController =
      StreamController<BookmarksApodState>();

  Sink<BookmarksApodEvent> get input => _inputController.sink;
  Stream<BookmarksApodState> get stream => _outputController.stream;

  void _mapEventToState(BookmarksApodEvent event) {}
}
