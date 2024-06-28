import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/repositories/search/search_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/search/fetch_apod_by_range.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'fetch_apod_by_range_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SearchRepository>()])
void main() {
  late MockSearchRepository repository;
  late FetchApodByRange useCase;

  setUp(() {
    repository = MockSearchRepository();
    useCase = FetchApodByRange(repository: repository);
  });

  group("fetchApodByDateRange tests", () {
    //sucesso
    test(
        "Should return a Right<List<ApodEntity>> if the repository call is a success",
        () async {
      //act
      when(repository.getApodByDateRange(any, any))
          .thenAnswer((_) async => Right(testListApodEntity));

      //arrange
      final result = await useCase("2022-05-05/2022-05-01");

      //assert
      expect(result, Right(testListApodEntity));
    });
    //erro - repository
    test("Should return a Left<Failure> if the repository call fail", () async {
      //act
      when(repository.getApodByDateRange(any, any))
          .thenAnswer((_) async => Left(NoConnectionFailure()));

      //arrange
      final result = await useCase("2022-05-05/2022-05-01");

      //assert
      expect(result, Left(NoConnectionFailure()));
    });

    // input errado
    test("Should return a Left<Failure> if the repository call fail", () async {
      //act
      when(repository.getApodByDateRange(any, any))
          .thenAnswer((_) async => Left(ConvertFailure()));

      //arrange
      final result = await useCase("2022-05-052022-05-01");

      //assert
      expect(result, Left(ConvertFailure()));
    });
  });
}
