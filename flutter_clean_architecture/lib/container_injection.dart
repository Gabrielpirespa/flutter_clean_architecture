import 'package:flutter_clean_architecture/data/datasources/fetch_apods/fetch_apods_data_source.dart';
import 'package:flutter_clean_architecture/data/datasources/fetch_apods/fetch_apods_data_source_impl.dart';
import 'package:flutter_clean_architecture/data/datasources/network/network_info.dart';
import 'package:flutter_clean_architecture/data/datasources/search/contracts/search_local_data_source.dart';
import 'package:flutter_clean_architecture/data/datasources/search/contracts/search_remote_data_source.dart';
import 'package:flutter_clean_architecture/data/datasources/search/search_local_data_source_impl.dart';
import 'package:flutter_clean_architecture/data/datasources/search/search_remote_data_source_impl.dart';
import 'package:flutter_clean_architecture/data/datasources/today_apod/today_apod_datasource.dart';
import 'package:flutter_clean_architecture/data/datasources/today_apod/today_apod_datasource_impl.dart';
import 'package:flutter_clean_architecture/data/repositories/fetch_apods/fetch_apods_repository_impl.dart';
import 'package:flutter_clean_architecture/data/repositories/search/search_repository_impl.dart';
import 'package:flutter_clean_architecture/data/repositories/today_apod/today_apod_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/repositories/fetch_apods/fetch_apods_repository.dart';
import 'package:flutter_clean_architecture/domain/repositories/search/search_repository.dart';
import 'package:flutter_clean_architecture/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/fetch_apods/fetch_apods.dart';
import 'package:flutter_clean_architecture/domain/usecases/search/fetch_apod_by_range.dart';
import 'package:flutter_clean_architecture/domain/usecases/search/fetch_search_history.dart';
import 'package:flutter_clean_architecture/domain/usecases/search/update_search_history.dart';
import 'package:flutter_clean_architecture/domain/usecases/today_apod/fetch_apod_today.dart';
import 'package:flutter_clean_architecture/presentation/bloc/fetch_apods/fetch_apods_bloc.dart';
import 'package:flutter_clean_architecture/presentation/bloc/search/search_bloc.dart';
import 'package:flutter_clean_architecture/presentation/bloc/today_apod/today_apod_bloc.dart';
import 'package:flutter_clean_architecture/route_generator.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt =
    GetIt.instance; //injeção de dependência das mais famosas no Flutter

Future<void> setUpContainer() async {
  // Dependências externas
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Dependências internas
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  // routes
  getIt.registerLazySingleton(() => RouteGenerator());

  // features
  apodTodayFeature(); // registra as dependências de cada feature individualmente.
  searchFeature();
  fetchApods();
}

void apodTodayFeature() {
  getIt.registerLazySingleton<TodayApodDataSource>(
      () => TodayApodDataSourceImpl(getIt()));

  getIt.registerLazySingleton<TodayApodRepository>(
      () => TodayApodRepositoryImpl(getIt(), getIt()));

  getIt.registerLazySingleton<FetchApodToday>(
      () => FetchApodToday(repository: getIt()));

  getIt.registerFactory(() => TodayApodBloc(fetchApodToday: getIt()));
}

void searchFeature() {
  getIt.registerLazySingleton<SearchLocalDataSource>(
      () => SearchLocalDatasourceImpl(sharedPreferences: getIt()));
  getIt.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(client: getIt()));

  getIt.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl(
      searchRemoteDataSource: getIt(),
      searchLocalDataSource: getIt(),
      networkInfo: getIt()));

  getIt.registerLazySingleton(() => FetchSearchHistory(repository: getIt()));
  getIt.registerLazySingleton(() => FetchApodByRange(repository: getIt()));
  getIt.registerLazySingleton(() => UpdateSearchHistory(repository: getIt()));

  getIt.registerFactory(() => SearchBloc(
      fetchSearchHistory: getIt(),
      updateSearchHistory: getIt(),
      fetchApodByRange: getIt()));
}

void fetchApods() {
  getIt.registerLazySingleton<FetchApodsDataSource>(
      () => FetchApodsDataSourceImpl(client: getIt()));

  getIt.registerLazySingleton<FetchApodsRepository>(() =>
      FetchApodsRepositoryImpl(
          fetchApodsDataSource: getIt(), networkInfo: getIt()));

  getIt.registerLazySingleton(() => FetchApods(repository: getIt()));

  getIt.registerFactory(() => FetchApodsBloc(fetchApods: getIt()));
}
