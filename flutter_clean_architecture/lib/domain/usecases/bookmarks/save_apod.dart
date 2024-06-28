import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/core/success.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';
import 'package:flutter_clean_architecture/domain/repositories/bookmarks/bookmarks_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/core/usecase.dart';

class SaveApod extends UseCase<ApodSave, ApodEntity> {
  final BookmarksApodRepository repository;

  SaveApod({required this.repository});

  @override
  Future<Either<Failure, ApodSave>> call(ApodEntity parameter) async {
    return await repository.saveApod(parameter);
  }
}
