import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/data/datasources/search/contracts/search_local_data_source.dart';
import 'package:flutter_clean_architecture/data/datasources/search/search_local_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../test_values.dart';
import 'search_local_data_source_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  late MockSharedPreferences sharedPreferences;
  late SearchLocalDataSource localDataSource;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localDataSource =
        SearchLocalDatasourceImpl(sharedPreferences: sharedPreferences);
  });

  group("fetchSearchHistory tests", () {
    test(
        "Should return a List<String> if the call of the LocalDataSource succeed",
        () async {
      //Arrange
      when(sharedPreferences.getStringList(any))
          .thenAnswer((_) => testHistoryList);
      //Act
      final result = await localDataSource.fetchSearchHistory();

      //Assert
      expect(result, testHistoryList);
    });

    test(
        "Should throw an AccessLocalDataFailure if the call of the LocalDataSource fails",
        () {
      //Arrange
      when(sharedPreferences.getStringList(any))
          .thenThrow(Exception("Exception"));
      //Act
      final result = localDataSource.fetchSearchHistory();

      //Assert
      expect(result, throwsA(isA<AccessLocalDataFailure>()));
    });
  });

  group("updateSearchHistory tests", () {
    test(
        "Should return a List<String> if the call of the LocalDataSource succeed",
        () async {
      //Arrange
      when(sharedPreferences.getStringList(any))
          .thenAnswer((_) => testHistoryList);
      when(sharedPreferences.setStringList(any, any))
          .thenAnswer((_) async => true);
      //Act
      final result = await localDataSource.updateSearchHistory(testHistoryList);

      //Assert
      expect(result, testHistoryList);
    });

    test(
        "Should throw an AccessLocalDataFailure if the call of the LocalDataSource fails",
        () {
      //Arrange
      when(sharedPreferences.getStringList(any))
          .thenAnswer((_) => testHistoryList);
      when(sharedPreferences.setStringList(any, any))
          .thenThrow(Exception("Exception"));

      //Act
      final result = localDataSource.updateSearchHistory(testHistoryList);

      //Assert
      expect(result, throwsA(isA<AccessLocalDataFailure>()));
    });
  });
}
