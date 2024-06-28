import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/core/success.dart';
import 'package:flutter_clean_architecture/data/datasources/bookmarks/bookmarks_datasource.dart';
import 'package:flutter_clean_architecture/data/repositories/bookmarks/bookmarks_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/repositories/bookmarks/bookmarks_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'bookmarks_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<BookmarksDataSource>()])
void main() {
  late MockBookmarksDataSource dataSource;
  late BookmarksApodRepository repository;

  setUp(() {
    dataSource = MockBookmarksDataSource();
    repository = BookmarksRepositoryImpl(bookmarksDataSource: dataSource);
  });

  group("saveApods tests", () {
    test("Should return a SuccessReturn on the Right side of Either", () async {
      //Arrange
      when(dataSource.saveApod(any)).thenAnswer((_) async => ApodSave());

      //Act
      final result = await repository.saveApod(testApodEntity);

      //Assert
      expect(result, Right(ApodSave()));
    });

    test(
        "Should return a Failure throw by the dataSource on the Left side of Either",
        () async {
      //Arrange
      when(dataSource.saveApod(any)).thenThrow(AccessLocalDataFailure());

      //Act
      final result = await repository.saveApod(testApodEntity);

      //Assert
      expect(result, Left(AccessLocalDataFailure()));
    });
  });

  group("removeSavedApods tests", () {
    test("Should return a SuccessReturn on the Right side of Either", () async {
      //Arrange
      when(dataSource.removeSavedApod(any))
          .thenAnswer((_) async => ApodRemove());

      //Act
      final result = await repository.removeSavedApod("date");

      //Assert
      expect(result, Right(ApodRemove()));
    });

    test(
        "Should return a Failure throw by the dataSource on the Left side of Either",
        () async {
      //Arrange
      when(dataSource.removeSavedApod(any)).thenThrow(AccessLocalDataFailure());

      //Act
      final result = await repository.removeSavedApod("date");

      //Assert
      expect(result, Left(AccessLocalDataFailure()));
    });
  });

  group("isApodSaves tests", () {
    test("Should return a SuccessReturn on the Right side of Either", () async {
      //Arrange
      when(dataSource.isApodSaved(any)).thenAnswer((_) async => true);

      //Act
      final result = await repository.isApodSaved("date");

      //Assert
      expect(result, const Right(true));
    });

    test(
        "Should return a Failure throw by the dataSource on the Left side of Either",
        () async {
      //Arrange
      when(dataSource.isApodSaved(any)).thenThrow(AccessLocalDataFailure());

      //Act
      final result = await repository.isApodSaved("date");

      //Assert
      expect(result, Left(AccessLocalDataFailure()));
    });
  });

  group("fetchAllSavedApods tests", () {
    test("Should return a SuccessReturn on the Right side of Either", () async {
      //Arrange
      when(dataSource.fetchAllSavedApods())
          .thenAnswer((_) async => testListApodModel);

      //Act
      final result = await repository.fetchAllSavedApods();

      //Assert
      expect(result, Right(testListApodModel));
    });

    test(
        "Should return a Failure throw by the dataSource on the Left side of Either",
        () async {
      //Arrange
      when(dataSource.fetchAllSavedApods()).thenThrow(AccessLocalDataFailure());

      //Act
      final result = await repository.fetchAllSavedApods();

      //Assert
      expect(result, Left(AccessLocalDataFailure()));
    });
  });
}
