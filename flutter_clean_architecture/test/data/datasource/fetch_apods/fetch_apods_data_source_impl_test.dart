import 'dart:convert';
import 'dart:io';

import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/data/datasources/fetch_apods/fetch_apods_data_source.dart';
import 'package:flutter_clean_architecture/data/datasources/fetch_apods/fetch_apods_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../../fixtures/fixtures.dart';
import '../../../mocks/mocks.mocks.dart';
import '../../../test_values.dart';

void main() {
  late MockClient client;
  late FetchApodsDataSource fetchApodsDataSource;

  setUp(() {
    client = MockClient();
    fetchApodsDataSource = FetchApodsDataSourceImpl(client: client);
  });

  group('fetchApods tests', () {
    test('Should return a List<ApodModel> if the RemoteDataSource call succeed',
        () async {
      //Arrange
      http.Response testResponseSuccessList =
          http.Response.bytes(utf8.encode(fixtures("apod_list.json")), 200);
      when(client.get(any)).thenAnswer((_) async => testResponseSuccessList);

      //Act
      final result = await fetchApodsDataSource.fetchApods();

      //Assert
      expect(result, testListApodModel);
    });

    test(
        'Should throw an ServerFailure if the RemoteDataSource call response is a 500',
        () async {
      //Arrange
      when(client.get(any)).thenAnswer(
          (_) async => http.Response.bytes(utf8.encode("erro"), 500));

      //Act
      final result = fetchApodsDataSource.fetchApods();

      //Assert
      expect(result, throwsA(isA<ServerFailure>()));
    });

    test('Should throw an ServerFailure if the RemoteDataSource call fails',
        () async {
      //Arrange
      when(client.get(any)).thenThrow(const SocketException("message"));

      //Act
      final result = fetchApodsDataSource.fetchApods();

      //Assert
      expect(result, throwsA(isA<ServerFailure>()));
    });
  });
}
