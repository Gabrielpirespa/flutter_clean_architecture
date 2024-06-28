import 'dart:convert';
import 'dart:io';

import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/data/datasources/today_apod/today_apod_datasource.dart';
import 'package:flutter_clean_architecture/data/datasources/today_apod/today_apod_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixtures.dart';
import '../../../mocks/mocks.mocks.dart';
import '../../../test_values.dart';

void main() {
  late MockClient client;
  late TodayApodDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = TodayApodDataSourceImpl(client);
  });

  group("testes para fetchTodayApod", () {
    test("Deve retornar um Apod model caso a requisição seja um sucesso",
        () async {
      //Arrange
      when(client.get(any)).thenAnswer((_) async => http.Response.bytes(
          utf8.encode(fixtures("image_response.json")), 200));
      //Act
      final result = await remoteDataSource.fetchTodayApod();
      //Assert
      expect(result, testApodModel);
    });

    test(
        "Deve lançar uma ServerFailure caso o status da requisição seja diferente de 200",
        () async {
      //Arrange
      when(client.get(any)).thenAnswer((_) async => http.Response.bytes(
          utf8.encode(fixtures("image_response.json")), 500));
      //Act
      final result = remoteDataSource.fetchTodayApod();

      //Assert
      expect(() => result, throwsA(isA<ServerFailure>()));
    });

    test("Deve lançar uma ServerFailure caso a requisição caia em uma exceção",
        () async {
      //Arrange
      when(client.get(any)).thenThrow(const SocketException("message"));
      //Act
      final result = remoteDataSource.fetchTodayApod();

      //Assert
      expect(result, throwsA(isA<ServerFailure>()));
    });
  });
}
