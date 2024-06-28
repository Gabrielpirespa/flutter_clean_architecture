import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/core/success.dart';
import 'package:flutter_clean_architecture/domain/usecases/bookmarks/remove_saved_apod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'is_apod_saved_test.mocks.dart';

void main() {
  late MockBookmarksApodRepository repository;
  late RemoveSavedApod useCase;

  setUp(() {
    repository = MockBookmarksApodRepository();
    useCase = RemoveSavedApod(repository: repository);
  });

  test("Should return a SuccesReturn on Right side of Either", () async {
    //Arrange
    when(repository.removeSavedApod(any))
        .thenAnswer((_) async => Right<Failure, ApodRemove>(ApodRemove()));

    //Act
    final result = await useCase("date");

    //Assert
    expect(result, Right<Failure, ApodRemove>(ApodRemove()));
  });

  test("Should return an Failure on Left side of Either", () async {
    //Arrange
    when(repository.removeSavedApod(any)).thenAnswer(
        (_) async => Left<Failure, ApodRemove>(AccessLocalDataFailure()));

    //Act
    final result = await useCase("date");

    //Assert
    expect(result, Left(AccessLocalDataFailure()));
  });
}
