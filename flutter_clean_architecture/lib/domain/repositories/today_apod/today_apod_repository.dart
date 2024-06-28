import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';

abstract class TodayApodRepository {
  Future<Either<Failure, ApodEntity>> fetchApodToday();
}
