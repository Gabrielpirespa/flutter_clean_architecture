// Mocks generated by Mockito 5.4.4 from annotations
// in flutter_clean_architecture/test/presentation/bloc/today_apod/today_apod_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:flutter_clean_architecture/core/failure.dart' as _i6;
import 'package:flutter_clean_architecture/domain/entities/apod_entity.dart'
    as _i7;
import 'package:flutter_clean_architecture/domain/repositories/today_apod/today_apod_repository.dart'
    as _i2;
import 'package:flutter_clean_architecture/domain/usecases/core/usecase.dart'
    as _i8;
import 'package:flutter_clean_architecture/domain/usecases/today_apod/fetch_apod_today.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTodayApodRepository_0 extends _i1.SmartFake
    implements _i2.TodayApodRepository {
  _FakeTodayApodRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FetchApodToday].
///
/// See the documentation for Mockito's code generation for more information.
class MockFetchApodToday extends _i1.Mock implements _i4.FetchApodToday {
  @override
  _i2.TodayApodRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTodayApodRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeTodayApodRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TodayApodRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.ApodEntity>> call(
          _i8.NoParameter? parameter) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [parameter],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.ApodEntity>>.value(
            _FakeEither_1<_i6.Failure, _i7.ApodEntity>(
          this,
          Invocation.method(
            #call,
            [parameter],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.ApodEntity>>.value(
                _FakeEither_1<_i6.Failure, _i7.ApodEntity>(
          this,
          Invocation.method(
            #call,
            [parameter],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.ApodEntity>>);
}
