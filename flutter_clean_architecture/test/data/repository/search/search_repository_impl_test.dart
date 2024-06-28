import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/data/datasources/network/network_info.dart';
import 'package:flutter_clean_architecture/data/datasources/search/contracts/search_local_data_source.dart';
import 'package:flutter_clean_architecture/data/datasources/search/contracts/search_remote_data_source.dart';
import 'package:flutter_clean_architecture/data/repositories/search/search_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/repositories/search/search_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'search_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SearchRemoteDataSource>(),
  MockSpec<SearchLocalDataSource>(),
  MockSpec<NetworkInfo>()
])
void main() {
  late MockSearchLocalDataSource localDataSource;
  late MockSearchRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  late SearchRepository searchRepository;

  setUp(() {
    localDataSource = MockSearchLocalDataSource();
    remoteDataSource = MockSearchRemoteDataSource();
    networkInfo = MockNetworkInfo();
    searchRepository = SearchRepositoryImpl(
        searchRemoteDataSource: remoteDataSource,
        searchLocalDataSource: localDataSource,
        networkInfo: networkInfo);
  });

  group("getApodByDateRange tests", () {
    test(
        "Should return a list of ApodModel if the RemoteDataSource call succeed",
        () async {
      //Arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.getApodByDateRange(any, any))
          .thenAnswer((_) async => testListApodModel);
      //Act
      final result =
          await searchRepository.getApodByDateRange("2022-05-05", "2022-05-01");
      //Assert
      expect(result, Right(testListApodModel));
    });
    test("Should return a Failure if the RemoteDataSource call fails",
        () async {
      //Arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.getApodByDateRange(any, any))
          .thenThrow(ServerFailure());
      //Act
      final result =
          await searchRepository.getApodByDateRange("2022-05-05", "2022-05-01");
      //Assert
      expect(result, Left(ServerFailure()));
    });

    test("Should return a NoConnectionFailure if there's no internet",
        () async {
      //Arrange
      when(networkInfo.isConnected).thenAnswer((_) async => false);
      //Act
      final result =
          await searchRepository.getApodByDateRange("2022-05-05", "2022-05-01");
      //Assert
      expect(result, Left(NoConnectionFailure()));
    });
  });

  group("fetchSearchHistory tests", () {
    test("Should return a list of String if the LocalDataSource call succeed",
        () async {
      //Arrange
      when(localDataSource.fetchSearchHistory())
          .thenAnswer((_) async => testHistoryList);
      //Act
      final result = await searchRepository.fetchSearchHistory();
      //Assert
      expect(result, Right(testHistoryList));
    });
    test("Should return a Failure if the LocalDataSource call fails", () async {
      //Arrange
      when(localDataSource.fetchSearchHistory())
          .thenThrow(AccessLocalDataFailure());
      //Act
      final result = await searchRepository.fetchSearchHistory();
      //Assert
      expect(result, Left(AccessLocalDataFailure()));
    });
  });

  group("updateSearchHistory tests", () {
    test("Should return a list of String if the LocalDataSource call succeed",
        () async {
      //Arrange
      when(localDataSource.updateSearchHistory(any))
          .thenAnswer((_) async => testHistoryList);
      //Act
      final result =
          await searchRepository.updateSearchHistory(testHistoryList);
      //Assert
      expect(result, Right(testHistoryList));
    });
    test("Should return a Failure if the LocalDataSource call fails", () async {
      //Arrange
      when(localDataSource.updateSearchHistory(any))
          .thenThrow(AccessLocalDataFailure());
      //Act
      final result =
          await searchRepository.updateSearchHistory(testHistoryList);
      //Assert
      expect(result, Left(AccessLocalDataFailure()));
    });
  });
}
