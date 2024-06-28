import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';
import 'package:flutter_clean_architecture/domain/repositories/fetch_apods/fetch_apods_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/core/usecase.dart';

class FetchApods extends UseCase<List<ApodEntity>, NoParameter> {
  final FetchApodsRepository repository;

  FetchApods({required this.repository});

  @override
  Future<Either<Failure, List<ApodEntity>>> call(NoParameter parameter) async {
    return repository.fetchApods();
  }
}
