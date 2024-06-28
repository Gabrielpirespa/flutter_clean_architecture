import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/usecases/core/usecase.dart';
import 'package:flutter_clean_architecture/domain/usecases/search/fetch_search_history.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'fetch_apod_by_range_test.mocks.dart';

void main() {
  late MockSearchRepository repository;
  late FetchSearchHistory useCase;

  setUp(() {
    repository = MockSearchRepository();
    useCase = FetchSearchHistory(repository: repository);
  });

  group("fetchSearchHistory tests", () {
    //sucesso
    test(
        "Should return a Right<List<String>> if the repository call is a success",
        () async {
      //act
      when(repository.fetchSearchHistory())
          .thenAnswer((_) async => Right(testHistoryList));

      //arrange
      final result = await useCase(NoParameter());

      //assert
      expect(result, Right(testHistoryList));
    });
    //erro - repository
    test("Should return a Left<Failure> if the repository call fails",
        () async {
      //act
      when(repository.fetchSearchHistory())
          .thenAnswer((_) async => Left(AccessLocalDataFailure()));

      //arrange
      final result = await useCase(NoParameter());

      //assert
      expect(result, Left(AccessLocalDataFailure()));
    });
  });
}
