import 'dart:convert';
import 'dart:io';

import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/data/datasources/search/contracts/search_remote_data_source.dart';
import 'package:flutter_clean_architecture/data/datasources/search/search_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixtures.dart';
import '../../../mocks/mocks.mocks.dart';
import '../../../test_values.dart';

void main() {
  late MockClient client;
  late SearchRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = SearchRemoteDataSourceImpl(client: client);
  });

  group("getApodByDateRange tests", () {
    test(
        "Should return a List<ApodModel> when the RemoteDataSource call is a success",
        () async {
      //Arrange
      when(client.get(any)).thenAnswer((_) async =>
          http.Response.bytes(utf8.encode(fixtures("apod_list.json")), 200));
      //Act
      final result =
          await remoteDataSource.getApodByDateRange("2023-05-05", "2023-05-01");
      //Assert
      expect(result, testListApodModel);
    });

    test("Should throw an ServerFailure when the RemoteDataSource call fails",
        () {
      //Arrange
      when(client.get(any)).thenAnswer((_) async =>
          http.Response.bytes(utf8.encode(fixtures("apod_list.json")), 500));
      //Act
      final result =
          remoteDataSource.getApodByDateRange("2023-05-05", "2023-05-01");
      //Assert
      expect(result, throwsA(isA<ServerFailure>()));
    });

    test("Should throw an ServerFailure when a Exception happens", () {
      //Arrange
      when(client.get(any)).thenThrow(const SocketException("message"));
      //Act
      final result =
          remoteDataSource.getApodByDateRange("2023-05-05", "2023-05-01");
      //Assert
      expect(result, throwsA(isA<ServerFailure>()));
    });
  });
}
