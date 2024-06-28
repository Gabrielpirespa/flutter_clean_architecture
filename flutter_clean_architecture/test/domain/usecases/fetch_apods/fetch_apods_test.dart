import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/repositories/fetch_apods/fetch_apods_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/core/usecase.dart';
import 'package:flutter_clean_architecture/domain/usecases/fetch_apods/fetch_apods.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'fetch_apods_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FetchApodsRepository>()])
void main() {
  late MockFetchApodsRepository repository;
  late FetchApods useCase;

  setUp(() {
    repository = MockFetchApodsRepository();
    useCase = FetchApods(repository: repository);
  });

  group("FetchApods() tests", () {
    test(
        "Should return a Right(List<ApodEntity>) in case the repository call succeed",
        () async {
      //Arrange
      when(repository.fetchApods())
          .thenAnswer((_) async => Right(testListApodEntity));
      //Act
      final result = await useCase(NoParameter());

      //Assert
      expect(result, Right(testListApodEntity));
    });

    test("Should return a Left(Failure) in case the repository call fails",
        () async {
      //Arrange
      when(repository.fetchApods())
          .thenAnswer((_) async => Left(NoConnectionFailure()));

      //Act
      final result = await useCase(NoParameter());

      //Assert
      expect(result, Left(NoConnectionFailure()));
    });
  });
}
