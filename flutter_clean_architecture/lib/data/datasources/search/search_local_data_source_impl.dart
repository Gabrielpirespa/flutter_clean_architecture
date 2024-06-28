import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/data/datasources/search/contracts/search_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchLocalDatasourceImpl implements SearchLocalDataSource {
  final SharedPreferences sharedPreferences;

  SearchLocalDatasourceImpl({required this.sharedPreferences});

  final String _historyKey = "historyKey";

  @override
  Future<List<String>> fetchSearchHistory() async {
    try {
      return sharedPreferences.getStringList(_historyKey) ?? [];
    } catch (e) {
      throw AccessLocalDataFailure();
    }
  }

  @override
  Future<List<String>> updateSearchHistory(List<String> history) async {
    try {
      await sharedPreferences.setStringList(_historyKey, history);
      return fetchSearchHistory();
    } catch (e) {
      throw AccessLocalDataFailure();
    }
  }
}
