import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/data/datasources/fetch_apods/fetch_apods_data_source.dart';
import 'package:flutter_clean_architecture/data/datasources/network/network_info.dart';
import 'package:flutter_clean_architecture/data/repositories/fetch_apods/fetch_apods_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/repositories/fetch_apods/fetch_apods_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'fetch_apods_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FetchApodsDataSource>(), MockSpec<NetworkInfo>()])
void main() {
  late MockFetchApodsDataSource fetchApodsDataSource;
  late MockNetworkInfo networkInfo;
  late FetchApodsRepository repository;

  setUp(() {
    fetchApodsDataSource = MockFetchApodsDataSource();
    networkInfo = MockNetworkInfo();
    repository = FetchApodsRepositoryImpl(
        fetchApodsDataSource: fetchApodsDataSource, networkInfo: networkInfo);
  });

  group("fetchApods tests", () {
    test(
        "Should return a Right(List<ApodEntity>) if the RemoteDataSource call succeed",
        () async {
      //Arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(fetchApodsDataSource.fetchApods())
          .thenAnswer((_) async => testListApodModel);

      //Act
      final result = await repository.fetchApods();

      //Assert
      expect(result, Right(testListApodModel));
    });

    test("Should return a Left(Failure()) if the RemoteDataSource call fails",
        () async {
      //Arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(fetchApodsDataSource.fetchApods()).thenThrow(ServerFailure());

      //Act
      final result = await repository.fetchApods();

      //Assert
      expect(result, Left(ServerFailure()));
    });

    test("Should return a Left(Failure()) if there's no connection", () async {
      //Arrange
      when(networkInfo.isConnected).thenAnswer((_) async => false);

      //Act
      final result = await repository.fetchApods();

      //Assert
      verifyNever(fetchApodsDataSource.fetchApods());
      expect(result, Left(NoConnectionFailure()));
    });
  });
}
