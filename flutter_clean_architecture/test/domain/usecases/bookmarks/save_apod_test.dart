import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/core/success.dart';
import 'package:flutter_clean_architecture/domain/usecases/bookmarks/save_apod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'is_apod_saved_test.mocks.dart';

void main() {
  late MockBookmarksApodRepository repository;
  late SaveApod useCase;

  setUp(() {
    repository = MockBookmarksApodRepository();
    useCase = SaveApod(repository: repository);
  });

  test("Should return a SuccesReturn on Right side of Either", () async {
    //Arrange
    when(repository.saveApod(any))
        .thenAnswer((_) async => Right<Failure, ApodSave>(ApodSave()));

    //Act
    final result = await useCase(testApodEntity);

    //Assert
    expect(result, Right<Failure, ApodSave>(ApodSave()));
  });

  test("Should return an Failure on Left side of Either", () async {
    //Arrange
    when(repository.saveApod(any)).thenAnswer(
        (_) async => Left<Failure, ApodSave>(AccessLocalDataFailure()));

    //Act
    final result = await useCase(testApodEntity);

    //Assert
    expect(result, Left(AccessLocalDataFailure()));
  });
}
