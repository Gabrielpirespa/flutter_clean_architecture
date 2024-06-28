import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';
import 'package:flutter_clean_architecture/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/core/usecase.dart';

class FetchApodToday extends UseCase<ApodEntity, NoParameter> {
  final TodayApodRepository repository;

  FetchApodToday({required this.repository});

  @override
  Future<Either<Failure, ApodEntity>> call(NoParameter parameter) async {
    return await repository.fetchApodToday();
  }
}
