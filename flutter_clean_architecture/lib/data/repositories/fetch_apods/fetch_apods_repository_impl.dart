import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/data/datasources/fetch_apods/fetch_apods_data_source.dart';
import 'package:flutter_clean_architecture/data/datasources/network/network_info.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';
import 'package:flutter_clean_architecture/domain/repositories/fetch_apods/fetch_apods_repository.dart';

class FetchApodsRepositoryImpl implements FetchApodsRepository {
  FetchApodsDataSource fetchApodsDataSource;
  NetworkInfo networkInfo;

  FetchApodsRepositoryImpl(
      {required this.fetchApodsDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<ApodEntity>>> fetchApods() async {
    if (await networkInfo.isConnected) {
      try {
        final apod = await fetchApodsDataSource.fetchApods();
        return Right(apod);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
