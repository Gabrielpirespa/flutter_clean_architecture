import 'dart:convert';
import 'package:flutter_clean_architecture/core/date_convert.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/core/success.dart';
import 'package:flutter_clean_architecture/data/datasources/bookmarks/bookmarks_datasource.dart';
import 'package:flutter_clean_architecture/data/models/apod_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarksDataSourceImpl implements BookmarksDataSource {
  final SharedPreferences preferences;
  BookmarksDataSourceImpl({required this.preferences});

  @override
  Future<List<ApodModel>> fetchAllSavedApods() async {
    try {
      final keys = preferences.getKeys();
      List<ApodModel> apodsList = [];
      for (var key in keys) {
        final apod = preferences.getString(key);
        if (apod != null) {
          apodsList.add(ApodModel.fromJson(jsonDecode(apod)));
        }
      }
      return apodsList;
    } catch (e) {
      throw AccessLocalDataFailure();
    }
  }

  @override
  Future<bool> isApodSaved(String apodDate) async {
    try {
      return preferences.containsKey(apodDate);
    } catch (e) {
      throw AccessLocalDataFailure();
    }
  }

  @override
  Future<ApodRemove> removeSavedApod(String apodDate) async {
    try {
      await preferences.remove(apodDate);
      return ApodRemove();
    } catch (e) {
      throw AccessLocalDataFailure();
    }
  }

  @override
  Future<ApodSave> saveApod(ApodModel apodModel) async {
    try {
      await preferences.setString(DateConvert.dateToString(apodModel.date),
          jsonEncode(apodModel.toJson()));
      return ApodSave();
    } catch (e) {
      throw AccessLocalDataFailure();
    }
  }
}
