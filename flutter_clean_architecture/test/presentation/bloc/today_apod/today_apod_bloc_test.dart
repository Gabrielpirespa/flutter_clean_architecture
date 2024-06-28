import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/usecases/today_apod/fetch_apod_today.dart';
import 'package:flutter_clean_architecture/presentation/bloc/today_apod/today_apod_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'today_apod_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FetchApodToday>()])
void main() {
  late MockFetchApodToday fetchApodToday;
  late TodayApodBloc bloc;

  setUp(() {
    fetchApodToday = MockFetchApodToday();
    bloc = TodayApodBloc(fetchApodToday: fetchApodToday);
  });

  group("useCase - fetchTodayApood", () {
    //sucesso
    test("Deve emitir LoadingApodState and SuccesApodState", () {
      //Arrange
      when(fetchApodToday(any)).thenAnswer((_) async => Right(testApodEntity));

      //Act
      bloc.input.add(FetchApodTodayEvent());

      //Assert
      expect(
          bloc.stream,
          emitsInOrder([
            LoadingTodayApodState(),
            SuccesTodayApodState(apod: testApodEntity)
          ]));
    });

    //falha
    test("Deve emitir LoadingApodState and ErrorApodState", () {
      //Arrange
      when(fetchApodToday(any))
          .thenAnswer((_) async => Left(NoConnectionFailure()));

      //Act
      bloc.input.add(FetchApodTodayEvent());

      //Assert
      expect(
          bloc.stream,
          emitsInOrder([
            LoadingTodayApodState(),
            ErrorTodayApodState(message: testNoConnection.msg)
          ]));
    });
  });
}
