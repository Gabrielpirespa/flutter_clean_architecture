import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';
import 'package:flutter_clean_architecture/domain/usecases/core/usecase.dart';
import 'package:flutter_clean_architecture/domain/usecases/fetch_apods/fetch_apods.dart';

part 'fetch_apods_event.dart';
part 'fetch_apods_state.dart';

class FetchApodsBloc {
  FetchApods fetchApods;

  FetchApodsBloc({required this.fetchApods}) {
    _inputController.stream.listen(_mapEventToState);
  }

  final StreamController<FetchApodsEvent> _inputController =
      StreamController<FetchApodsEvent>();

  final StreamController<FetchApodsState> _outputController =
      StreamController<FetchApodsState>();

  Sink<FetchApodsEvent> get input => _inputController.sink;
  Stream<FetchApodsState> get stream => _outputController.stream;

  void _mapEventToState(FetchApodsEvent event) {
    _outputController.add(LoadingFetchApodsState());

    if (event is MakeFetchApodsEvent) {
      fetchApods(NoParameter()).then((value) => value.fold(
          (failure) =>
              _outputController.add(ErrorFetchApodsState(msg: failure.msg)),
          (success) =>
              _outputController.add(SuccesListFetchApods(list: success))));
    }
  }
}
