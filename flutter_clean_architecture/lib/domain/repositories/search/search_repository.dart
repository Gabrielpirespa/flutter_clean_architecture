import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';

abstract class SearchRepository {
  //Return a list of Apod date on Right side of Either in case it is a success, otherwise
  //Return a Failure on Left side of Either
  Future<Either<Failure, List<ApodEntity>>> getApodByDateRange(
      String startDate, String endDate);

  //Return a list of String on Right side of Either in case it is a success, otherwise
  //Return a Failure on Left side of Either
  Future<Either<Failure, List<String>>> updateSearchHistory(
      List<String> historyList);

  //Return a list of String on Right side of Either in case it is a success, otherwise
  //Return a Failure on Left side of Either
  Future<Either<Failure, List<String>>> fetchSearchHistory();
}
