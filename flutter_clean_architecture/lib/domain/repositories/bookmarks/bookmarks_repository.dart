import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/core/success.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';

abstract class BookmarksApodRepository {
  /// Return a SuccesReturn on Right Side of either case is a success, otherwise
  /// Return a Failure on Left side of Either
  Future<Either<Failure, ApodSave>> saveApod(ApodEntity apod);

  /// Return a SuccesReturn on Right side of Either case is a success, otherwise
  /// Return a Failure on Left side of Either
  Future<Either<Failure, ApodRemove>> removeSavedApod(String apodDate);

  /// Return a true on Right side of Either case the apod is saved or false case
  /// the apod isn't saved, otherwise return a Failure on Left side of Either
  Future<Either<Failure, bool>> isApodSaved(String apodDate);

  /// Return an Apod List on Right side of Either case is a success, otherwise
  /// Return a Failure on Left side of Either
  Future<Either<Failure, List<ApodEntity>>> fetchAllSavedApods();
}
