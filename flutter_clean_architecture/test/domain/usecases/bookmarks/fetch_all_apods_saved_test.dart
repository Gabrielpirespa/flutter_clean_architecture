import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';
import 'package:flutter_clean_architecture/domain/usecases/bookmarks/fetch_all_saved_apods.dart';
import 'package:flutter_clean_architecture/domain/usecases/core/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'is_apod_saved_test.mocks.dart';

void main() {
  late MockBookmarksApodRepository repository;
  late FetchAllSavedApods useCase;

  setUp(() {
    repository = MockBookmarksApodRepository();
    useCase = FetchAllSavedApods(repository: repository);
  });

  test("Should return an Apod list on Right side of Either", () async {
    //Arrange
    when(repository.fetchAllSavedApods()).thenAnswer(
        (_) async => Right<Failure, List<ApodEntity>>(testListApodEntity));

    //Act
    final result = await useCase(NoParameter());

    //Assert
    expect(result, Right(testListApodEntity));
  });

  test("Should return an Apod list on Right side of Either", () async {
    //Arrange
    when(repository.fetchAllSavedApods()).thenAnswer(
        (_) async => Right<Failure, List<ApodEntity>>(testListApodEntity));

    //Act
    final result = await useCase(NoParameter());

    //Assert
    expect(result, Right(testListApodEntity));
  });

  test("Should return an Failure on Left side of Either", () async {
    //Arrange
    when(repository.fetchAllSavedApods()).thenAnswer(
        (_) async => Left<Failure, List<ApodEntity>>(AccessLocalDataFailure()));

    //Act
    final result = await useCase(NoParameter());

    //Assert
    expect(result, Left(AccessLocalDataFailure()));
  });
}
