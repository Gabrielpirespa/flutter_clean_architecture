import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/data/datasources/network/network_info.dart';
import 'package:flutter_clean_architecture/data/datasources/today_apod/today_apod_datasource.dart';
import 'package:flutter_clean_architecture/data/repositories/today_apod/today_apod_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_values.dart';

class _MockTodayApodDataSource extends Mock implements TodayApodDataSource {}

class _MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late TodayApodDataSource remoteDatasource;
  late NetworkInfo networkInfo;
  late TodayApodRepository repository;

  setUp(() {
    remoteDatasource = _MockTodayApodDataSource();
    networkInfo = _MockNetworkInfo();
    repository = TodayApodRepositoryImpl(remoteDatasource, networkInfo);
  });

  group("Testes para fetchTodayApod", () {
    test(
        "Deve retornar um ApodEntity caso tenha sucesso ao receber os dados do remoteDatasource",
        () async {
      //Arrange
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => remoteDatasource.fetchTodayApod())
          .thenAnswer((_) async => testApodModel);

      //Act
      final result = await repository.fetchApodToday();

      //Assert
      expect(result, Right(testApodModel));
    });
    test(
        "Deve retornar uma ServerFailure caso tenha internet mas falhe ao receber os dados do remoteDatasource",
        () async {
      //Arrange
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => remoteDatasource.fetchTodayApod()).thenThrow(ServerFailure());

      //Act
      final result = await repository.fetchApodToday();

      //Assert
      expect(result, Left(ServerFailure()));
    });
    test("Deve retornar uma NoConnectionFailure caso não tenha internet",
        () async {
      //Arrange
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);

      //Act
      final result = await repository.fetchApodToday();

      //Assert
      verifyNever(() => remoteDatasource.fetchTodayApod());
      expect(result, Left(NoConnectionFailure()));
    });
  });
}
