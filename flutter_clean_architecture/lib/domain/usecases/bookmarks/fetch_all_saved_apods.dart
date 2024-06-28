import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';
import 'package:flutter_clean_architecture/domain/repositories/bookmarks/bookmarks_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/core/usecase.dart';

class FetchAllSavedApods extends UseCase<List<ApodEntity>, NoParameter> {
  final BookmarksApodRepository repository;

  FetchAllSavedApods({required this.repository});

  @override
  Future<Either<Failure, List<ApodEntity>>> call(NoParameter parameter) async {
    return await repository.fetchAllSavedApods();
  }
}
