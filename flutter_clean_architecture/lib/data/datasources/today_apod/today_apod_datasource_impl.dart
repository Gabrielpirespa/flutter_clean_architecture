import 'dart:convert';

import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/data/datasources/today_apod/today_apod_datasource.dart';
import 'package:flutter_clean_architecture/data/models/apod_model.dart';
import 'package:flutter_clean_architecture/environment.dart';
import 'package:http/http.dart' as http;

class TodayApodDataSourceImpl implements TodayApodDataSource {
  final http.Client client;

  TodayApodDataSourceImpl(this.client);

  @override
  Future<ApodModel> fetchTodayApod() async {
    http.Response response;
    try {
      response = await client.get(Uri.parse(Environment.baseUrl));
    } catch (e) {
      throw ServerFailure();
    }

    if (response.statusCode == 200) {
      //utilizar o utf8 para não perder dados com caracteres especiais
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      return ApodModel.fromJson(json);
    } else {
      throw ServerFailure();
    }
  }
}
