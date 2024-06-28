import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/usecases/search/fetch_apod_by_range.dart';
import 'package:flutter_clean_architecture/domain/usecases/search/fetch_search_history.dart';
import 'package:flutter_clean_architecture/domain/usecases/search/update_search_history.dart';
import 'package:flutter_clean_architecture/presentation/bloc/search/search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'search_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FetchSearchHistory>(),
  MockSpec<UpdateSearchHistory>(),
  MockSpec<FetchApodByRange>()
])
void main() {
  late MockFetchSearchHistory fetchSearchHistory;
  late MockUpdateSearchHistory updateSearchHistory;
  late MockFetchApodByRange fetchApodByRange;
  late SearchBloc bloc;

  setUp(() {
    fetchSearchHistory = MockFetchSearchHistory();
    updateSearchHistory = MockUpdateSearchHistory();
    fetchApodByRange = MockFetchApodByRange();
    bloc = SearchBloc(
        fetchSearchHistory: fetchSearchHistory,
        updateSearchHistory: updateSearchHistory,
        fetchApodByRange: fetchApodByRange);
  });

  group("fetchSerachHistory tests", () {
    test("Should emit LoadingApodState and SuccesHistorySearchListApodState",
        () {
      //Arrange
      when(fetchSearchHistory(any))
          .thenAnswer((_) async => Right(testHistoryList));
      //Act
      bloc.input.add(FetchHistorySearchEvent());

      //Assert
      expect(
          bloc.stream,
          emitsInOrder([
            LoadingSearchState(),
            SuccessHistorySearchState(list: testHistoryList)
          ]));
    });

    test("Should emit LoadingApodState and ErrorapodState", () {
      //Arrange
      when(fetchSearchHistory(any))
          .thenAnswer((_) async => Left(AccessLocalDataFailure()));
      //Act
      bloc.input.add(FetchHistorySearchEvent());

      //Assert
      expect(
          bloc.stream,
          emitsInOrder([
            LoadingSearchState(),
            ErrorSearchState(msg: AccessLocalDataFailure().msg)
          ]));
    });
  });

  group("updateSearchHistory tests", () {
    test("Should emit LoadingApodState and SuccesHistorySearchListApodState",
        () {
      //Arrange
      when(updateSearchHistory(any))
          .thenAnswer((_) async => Right(testHistoryList));
      //Act
      bloc.input.add(UpdateHistorySearchEvent(list: testHistoryList));

      //Assert
      expect(
          bloc.stream,
          emitsInOrder([
            LoadingSearchState(),
            SuccessHistorySearchState(list: testHistoryList)
          ]));
    });

    test("Should emit LoadingApodState and ErrorapodState", () {
      //Arrange
      when(updateSearchHistory(any))
          .thenAnswer((_) async => Left(AccessLocalDataFailure()));
      //Act
      bloc.input.add(UpdateHistorySearchEvent(list: testHistoryList));

      //Assert
      expect(
          bloc.stream,
          emitsInOrder([
            LoadingSearchState(),
            ErrorSearchState(msg: AccessLocalDataFailure().msg)
          ]));
    });
  });

  group("fetchApodByRange tests", () {
    test("Should emit LoadingApodState and SuccessListApodState", () {
      //Arrange
      when(fetchApodByRange(any))
          .thenAnswer((_) async => Right(testListApodEntity));
      //Act
      bloc.input.add(const FetchByDateRangeSearchEvent(query: "Query"));

      //Assert
      expect(
          bloc.stream,
          emitsInOrder([
            LoadingSearchState(),
            SuccessListSearchState(list: testListApodEntity)
          ]));
    });

    test("Should emit LoadingApodState and ErrorApodState", () {
      //Arrange
      when(fetchApodByRange(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //Act
      bloc.input.add(const FetchByDateRangeSearchEvent(query: "Query"));

      //Assert
      expect(
          bloc.stream,
          emitsInOrder([
            LoadingSearchState(),
            ErrorSearchState(msg: ServerFailure().msg)
          ]));
    });
  });
}
