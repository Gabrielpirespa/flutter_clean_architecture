import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/core/usecase.dart';
import 'package:flutter_clean_architecture/domain/usecases/today_apod/fetch_apod_today.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_values.dart';

class _MockTodayRepository extends Mock implements TodayApodRepository {}

void main() {
  late TodayApodRepository repository;
  late FetchApodToday useCase;

  setUpAll(() {
    repository = _MockTodayRepository();
    useCase = FetchApodToday(repository: repository);
  });

  group("Testes para fetchApodToday", () {
    test(
        "Deve retornar um ApodEntity quando conseguir se comunicar com o repository",
        () async {
      //Arrange
      when(
        () => repository.fetchApodToday(),
      ).thenAnswer((invocation) async => Right(testApodEntity));
      //Act
      final result = await useCase.call(NoParameter());
      //Assert
      expect(result, Right(testApodEntity));
    });
    test(
        "Deve retornar uma NoConnectionFailure quando não conseguir se comunicar com o repository",
        () async {
      //Arrange
      when(
        () => repository.fetchApodToday(),
      ).thenAnswer((invocation) async => Left(NoConnectionFailure()));
      //Act
      final result = await useCase.call(NoParameter());
      //Assert
      expect(result, Left(NoConnectionFailure()));
    });
  });
}
