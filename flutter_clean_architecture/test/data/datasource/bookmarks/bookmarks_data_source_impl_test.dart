import 'dart:convert';

import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/core/success.dart';
import 'package:flutter_clean_architecture/data/datasources/bookmarks/bookmarks_datasource.dart';
import 'package:flutter_clean_architecture/data/datasources/bookmarks/bookmarks_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixtures.dart';
import '../../../test_values.dart';
import 'bookmarks_data_source_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  late MockSharedPreferences sharedPreferences;
  late BookmarksDataSource localDataSource;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localDataSource = BookmarksDataSourceImpl(preferences: sharedPreferences);
  });

  group('Function saveApod tests', () {
    test("Should return and ApodSave", () async {
      //Arrange
      when(sharedPreferences.setString(any, any)).thenAnswer((_) async => true);

      //Act
      final result = await localDataSource.saveApod(testApodModel);

      //Assert
      expect(result, ApodSave());
    });
    test(
        "Should throw a AccesLocalDataFailure when the sharedPreferences fails.",
        () async {
      //Arrange
      when(sharedPreferences.setString(any, any))
          .thenThrow(Exception("Exception"));

      //Act
      final result = localDataSource.saveApod(testApodModel);

      //Assert
      expect(result, throwsA(isA<AccessLocalDataFailure>()));
    });
  });

  group('Function removeSavedApods tests', () {
    test("Should return and ApodRemove", () async {
      //Arrange
      when(sharedPreferences.remove(any)).thenAnswer((_) async => true);

      //Act
      final result = await localDataSource.removeSavedApod("2004-09-27");

      //Assert
      expect(result, ApodRemove());
    });
    test(
        "Should throw a AccesLocalDataFailure when the sharedPreferences fails.",
        () async {
      //Arrange
      when(sharedPreferences.remove(any)).thenThrow(Exception("Exception"));

      //Act
      final result = localDataSource.removeSavedApod("2004-09-27");

      //Assert
      expect(result, throwsA(isA<AccessLocalDataFailure>()));
    });
  });
  group('Function isApodSaved tests', () {
    test("Should return true", () async {
      //Arrange
      when(sharedPreferences.containsKey(any)).thenAnswer((_) => true);

      //Act
      final result = await localDataSource.isApodSaved("2004-09-27");

      //Assert
      expect(result, true);
    });
    test("Should return false", () async {
      //Arrange
      when(sharedPreferences.containsKey(any)).thenAnswer((_) => false);

      //Act
      final result = await localDataSource.isApodSaved("2004-09-27");

      //Assert
      expect(result, false);
    });
    test(
        "Should throw an AccesLocalDataFailure when the sharedPreferences fails.",
        () async {
      //Arrange
      when(sharedPreferences.containsKey(any))
          .thenThrow(Exception("Exception"));

      //Act
      final result = localDataSource.isApodSaved("2004-09-27");

      //Assert
      expect(result, throwsA(isA<AccessLocalDataFailure>()));
    });
  });

  group('Function fetchAllSavedApods tests', () {
    test("Should return a List of Apod Model", () async {
      //Arrange
      when(sharedPreferences.getKeys()).thenReturn({"chave1"});
      when(sharedPreferences.getString(any))
          .thenAnswer((_) => fixtures("image_response.json"));

      //Act
      final result = await localDataSource.fetchAllSavedApods();

      //Assert
      expect(result, [testApodModel]);
    });
    test(
        "Should throw a AccesLocalDataFailure when the sharedPreferences fails.",
        () async {
      //Arrange
      when(sharedPreferences.getKeys()).thenReturn({"chave1"});
      when(sharedPreferences.getString(any)).thenThrow(Exception("Exception"));

      //Act
      final result = localDataSource.fetchAllSavedApods();

      //Assert
      expect(result, throwsA(isA<AccessLocalDataFailure>()));
    });
    test(
        "Should throw a AccesLocalDataFailure when the sharedPreferences fails.",
        () async {
      //Arrange
      when(sharedPreferences.getKeys()).thenThrow(Exception("Exception"));

      //Act
      final result = localDataSource.fetchAllSavedApods();

      //Assert
      expect(result, throwsA(isA<AccessLocalDataFailure>()));
    });
  });
}
