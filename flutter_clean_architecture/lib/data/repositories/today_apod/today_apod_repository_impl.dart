import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/data/datasources/network/network_info.dart';
import 'package:flutter_clean_architecture/data/datasources/today_apod/today_apod_datasource.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';
import 'package:flutter_clean_architecture/domain/repositories/today_apod/today_apod_repository.dart';

class TodayApodRepositoryImpl implements TodayApodRepository {
  final TodayApodDataSource remoteDatasource;
  final NetworkInfo networkInfo;

  const TodayApodRepositoryImpl(this.remoteDatasource, this.networkInfo);

  @override
  Future<Either<Failure, ApodEntity>> fetchApodToday() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDatasource.fetchTodayApod();
        return Right(result);
      } on ServerFailure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
