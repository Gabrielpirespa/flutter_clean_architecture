import 'package:flutter_clean_architecture/data/models/apod_model.dart';

abstract class SearchRemoteDataSource {
  //Return a ApodModel list case it's a success, otherwise
  // throw a Failure.
  Future<List<ApodModel>> getApodByDateRange(String startDate, String endDate);
}
