import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/usecases/fetch_apods/fetch_apods.dart';
import 'package:flutter_clean_architecture/presentation/bloc/fetch_apods/fetch_apods_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'fetch_apods_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FetchApods>()])
void main() {
  late FetchApodsBloc fetchApodsBloc;
  late MockFetchApods fetchApods;

  setUp(() {
    fetchApods = MockFetchApods();
    fetchApodsBloc = FetchApodsBloc(fetchApods: fetchApods);
  });

  group('FetchApods useCase test', () {
    test('Should emit LoadingFetchApodsState and SuccessListFetchApods', () {
      //Arrange
      when(fetchApods(any)).thenAnswer((_) async => Right(testListApodEntity));

      //Act
      fetchApodsBloc.input.add(MakeFetchApodsEvent());

      //Assert
      expect(
          fetchApodsBloc.stream,
          emitsInOrder([
            LoadingFetchApodsState(),
            SuccesListFetchApods(list: testListApodEntity)
          ]));
    });

    test('Should emit LoadingFetchApodsState and ErrorFetchApodsState', () {
      //Arrange
      when(fetchApods(any)).thenAnswer((_) async => Left(ServerFailure()));

      //Act
      fetchApodsBloc.input.add(MakeFetchApodsEvent());

      //Assert
      expect(
          fetchApodsBloc.stream,
          emitsInOrder([
            LoadingFetchApodsState(),
            ErrorFetchApodsState(msg: ServerFailure().msg)
          ]));
    });
  });
}
