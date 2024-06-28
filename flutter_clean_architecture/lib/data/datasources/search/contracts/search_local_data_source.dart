abstract class SearchLocalDataSource {
  // Return a list of String case is a success, otherwise
  // throw a Failure
  Future<List<String>> fetchSearchHistory();

  // Return a list of String case is a success, otherwise
  // throw a Failure
  Future<List<String>> updateSearchHistory(List<String> history);
}
