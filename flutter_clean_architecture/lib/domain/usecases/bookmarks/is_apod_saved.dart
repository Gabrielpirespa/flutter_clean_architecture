import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/repositories/bookmarks/bookmarks_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/core/usecase.dart';

class IsApodSaved extends UseCase<bool, String> {
  final BookmarksApodRepository repository;

  IsApodSaved({required this.repository});

  @override
  Future<Either<Failure, bool>> call(String parameter) async {
    return await repository.isApodSaved(parameter);
  }
}
