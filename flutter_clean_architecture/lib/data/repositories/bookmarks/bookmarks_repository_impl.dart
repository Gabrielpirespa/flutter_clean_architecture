import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/failure.dart';
import 'package:flutter_clean_architecture/core/success.dart';
import 'package:flutter_clean_architecture/data/datasources/bookmarks/bookmarks_datasource.dart';
import 'package:flutter_clean_architecture/data/models/apod_model.dart';
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart';
import 'package:flutter_clean_architecture/domain/repositories/bookmarks/bookmarks_repository.dart';

class BookmarksRepositoryImpl implements BookmarksApodRepository {
  final BookmarksDataSource bookmarksDataSource;

  BookmarksRepositoryImpl({required this.bookmarksDataSource});

  @override
  Future<Either<Failure, List<ApodEntity>>> fetchAllSavedApods() async {
    return _callDataSource(() => bookmarksDataSource.fetchAllSavedApods());
  }

  @override
  Future<Either<Failure, bool>> isApodSaved(String apodDate) async {
    return _callDataSource(() => bookmarksDataSource.isApodSaved(apodDate));
  }

  @override
  Future<Either<Failure, ApodRemove>> removeSavedApod(String apodDate) async {
    return _callDataSource(() => bookmarksDataSource.removeSavedApod(apodDate));
  }

  @override
  Future<Either<Failure, ApodSave>> saveApod(ApodEntity apod) async {
    return _callDataSource(
        () => bookmarksDataSource.saveApod(ApodModel.fromEntity(apod)));
  }

  Future<Either<Failure, A>> _callDataSource<A>(
      Future<A> Function() func) async {
    try {
      return Right(await func());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
