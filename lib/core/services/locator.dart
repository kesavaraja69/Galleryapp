import 'package:dio/dio.dart';
import 'package:galleryapp/core/api/fetchimages/fetchimages.api.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  //! Register Dio as a lazy singleton in the service locator
  locator.registerLazySingleton(() => Dio());

//! Register FetchimagesApi as a lazy singleton in the service locator,
//! injecting Dio as a dependency
  locator.registerLazySingleton(() => FetchimagesApi(locator<Dio>()));
}
