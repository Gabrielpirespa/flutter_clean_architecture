import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/usecases/search/update_search_history.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../test_values.dart';
import 'fetch_apod_by_range_test.mocks.dart';

void main() {
  late MockSearchRepository repository;
  late UpdateSearchHistory useCase;

  setUp(() {
    repository = MockSearchRepository();
    useCase = UpdateSearchHistory(repository: repository);
  });

  group("updateSearchHistory tests", () {
    //sucesso
    test(
        "Should return a Right<List<String>> if the repository call is a success",
        () async {
      //act
      when(repository.updateSearchHistory(testHistoryList))
          .thenAnswer((_) async => Right(testHistoryList));

      //arrange
      final result = await useCase(testHistoryList);

      //assert
      expect(result, Right(testHistoryList));
    });
    //erro - repository
    test("Should return a Left<Failure> if the repository call fails",
        () async {
      //act
      when(repository.updateSearchHistory(testHistoryList))
          .thenAnswer((_) async => Left(AccessLocalDataFailure()));

      //arrange
      final result = await useCase(testHistoryList);

      //assert
      expect(result, Left(AccessLocalDataFailure()));
    });
  });
}
