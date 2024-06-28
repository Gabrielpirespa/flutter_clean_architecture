import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';
import 'package:flutter_clean_architecture/domain/repositories/search/search_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/core/usecase.dart';

class FetchApodByRange extends UseCase<List<ApodEntity>, String> {
  final SearchRepository repository;
  FetchApodByRange({required this.repository});

  @override
  Future<Either<Failure, List<ApodEntity>>> call(String parameter) async {
    final query = toStandardQuery(parameter).fold((l) => l, (r) => r);

    if (query is Map) {
      return await repository.getApodByDateRange(query['start'], query['end']);
    } else {
      return Left(query as Failure);
    }
  }

  // 2023-08-13/2023-08-15
  Either<Failure, Map<String, dynamic>> toStandardQuery(String query) {
    if (query.length == 21) {
      final list = query.split('/');

      if (list.length == 2) {
        try {
          DateTime.tryParse(list[0]);
          DateTime.tryParse(list[1]);
          return Right({'start': list[0], 'end': list[1]});
        } catch (e) {
          return Left(ConvertFailure());
        }
      }
    }
    if (query.length == 10) {
      try {
        DateTime.tryParse(query);
        return Right({'start': query, 'end': query});
      } catch (e) {
        return Left(ConvertFailure());
      }
    } else {
      return Left(ConvertFailure());
    }
  }
}
