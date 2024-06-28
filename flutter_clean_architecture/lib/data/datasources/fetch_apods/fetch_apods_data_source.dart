import 'package:flutter_clean_architecture/data/models/apod_model.dart';

abstract class FetchApodsDataSource {
  Future<List<ApodModel>> fetchApods();
}
