import 'package:flutter_clean_architecture/core/success.dart';
import 'package:flutter_clean_architecture/data/models/apod_model.dart';

abstract class BookmarksDataSource {
  ///Return a [SuccesReturn] case is a success, otherwise
  ///throw a [Failure]
  Future<ApodSave> saveApod(ApodModel apodModel);

  ///Return a [SuccesReturn] case is a success, otherwise
  ///throw a [Failure]
  Future<ApodRemove> removeSavedApod(String apodDate);

  ///Return a [bool] case is a success,
  ///true to say the apod is saved and false when the apod is not saved,
  ///otherwise throw a [Failure]
  Future<bool> isApodSaved(String apodDate);

  ///Return a list [ApodModel] case is a success, otherwise
  ///throw a [Failure]
  Future<List<ApodModel>> fetchAllSavedApods();
}
