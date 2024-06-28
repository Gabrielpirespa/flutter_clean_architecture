import 'dart:convert';

import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/data/datasources/fetch_apods/fetch_apods_data_source.dart';
import 'package:flutter_clean_architecture/data/models/apod_model.dart';
import 'package:flutter_clean_architecture/environment.dart';
import 'package:http/http.dart' as http;

class FetchApodsDataSourceImpl implements FetchApodsDataSource {
  final http.Client client;

  FetchApodsDataSourceImpl({required this.client});

  @override
  Future<List<ApodModel>> fetchApods() async {
    http.Response response;
    try {
      response = await client.get(Uri.parse("${Environment.baseUrl}&count=20"));
    } catch (e) {
      throw ServerFailure();
    }

    if (response.statusCode == 200) {
      var json = jsonDecode(utf8.decode(response.bodyBytes));
      return List.from(json.map((e) => ApodModel.fromJson(e)));
    } else {
      throw ServerFailure();
    }
  }
}
