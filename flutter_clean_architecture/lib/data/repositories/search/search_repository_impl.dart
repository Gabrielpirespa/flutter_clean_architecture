import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/data/datasources/network/network_info.dart';
import 'package:flutter_clean_architecture/data/datasources/search/contracts/search_local_data_source.dart';
import 'package:flutter_clean_architecture/data/datasources/search/contracts/search_remote_data_source.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';
import 'package:flutter_clean_architecture/domain/repositories/search/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource searchRemoteDataSource;
  final SearchLocalDataSource searchLocalDataSource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl(
      {required this.searchRemoteDataSource,
      required this.searchLocalDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<ApodEntity>>> getApodByDateRange(
      String startDate, String endDate) async {
    if (await networkInfo.isConnected) {
      try {
        final apodList =
            await searchRemoteDataSource.getApodByDateRange(startDate, endDate);
        return Right(apodList);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> fetchSearchHistory() async {
    try {
      return Right(await searchLocalDataSource.fetchSearchHistory());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<String>>> updateSearchHistory(
      List<String> historyList) async {
    try {
      return Right(
          await searchLocalDataSource.updateSearchHistory(historyList));
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
