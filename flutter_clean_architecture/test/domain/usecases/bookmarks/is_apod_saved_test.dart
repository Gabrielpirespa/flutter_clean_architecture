import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/repositories/bookmarks/bookmarks_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/bookmarks/is_apod_saved.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'is_apod_saved_test.mocks.dart';

@GenerateNiceMocks([MockSpec<BookmarksApodRepository>()])
void main() {
  late MockBookmarksApodRepository repository;
  late IsApodSaved useCase;

  setUp(() {
    repository = MockBookmarksApodRepository();
    useCase = IsApodSaved(repository: repository);
  });

  group("Bookmarks UseCase tests", () {
    test("Should return a Right(bool) if the repository calls suceed",
        () async {
      //Arrange
      when(repository.isApodSaved(any))
          .thenAnswer((_) async => const Right<Failure, bool>(true));

      //Act
      final result = await useCase("date");

      //Assert
      expect(result, const Right<Failure, bool>(true));
    });

    test('Should return a Left(Failure())', () async {
      //Arrange
      when(repository.isApodSaved(any)).thenAnswer(
          (_) async => Left<Failure, bool>(AccessLocalDataFailure()));

      //Act
      final result = await useCase("date");

      //Assert
      expect(result, Left(AccessLocalDataFailure()));
    });
  });
}
