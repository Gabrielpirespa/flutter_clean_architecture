import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/core/success.dart';
import 'package:flutter_clean_architecture/domain/repositories/bookmarks/bookmarks_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/core/usecase.dart';

class RemoveSavedApod extends UseCase<ApodRemove, String> {
  final BookmarksApodRepository repository;

  RemoveSavedApod({required this.repository});

  @override
  Future<Either<Failure, ApodRemove>> call(String parameter) async {
    return await repository.removeSavedApod(parameter);
  }
}
