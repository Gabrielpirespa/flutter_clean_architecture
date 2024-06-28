import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/repositories/search/search_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/core/usecase.dart';

class UpdateSearchHistory extends UseCase<List<String>, List<String>> {
  final SearchRepository repository;
  UpdateSearchHistory({required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(List<String> parameter) async {
    return await repository.updateSearchHistory(parameter);
  }
}
