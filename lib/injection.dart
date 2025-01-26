import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:post_flutter_practical/core/api_provider.dart';
import 'package:post_flutter_practical/features/feat_posts/bloc/post_bloc.dart';
import 'package:post_flutter_practical/features/feat_posts/cubits/dot_indicator_cubit.dart';
import 'package:post_flutter_practical/features/feat_posts/repo/post_repo.dart';
import 'package:post_flutter_practical/features/feat_posts/repo/post_repo_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External /* All the other required external injection are embedded here */
  await _initExternalDependencies();

  // Repository /* All the repository injection are embedded here */
  _initRepositories();

  // Bloc /* All the bloc injection are embedded here */
  _initBlocs();

  // Cubits /* All the cubits injection are embedded here */
  _initCubits();
}

Future<void> _initBlocs() async {
  sl.registerFactory(() => PostBloc(postRepository: sl()));
}

Future<void> _initCubits() async {
  sl.registerFactory(() => DotIndicatorCubit());
}

void _initRepositories() {
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(apiClient: sl()));
}

Future<void> _initExternalDependencies() async {
  sl.registerLazySingleton(() => Logger());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => ApiProvider(addLogging: true));
  sl.registerLazySingleton(() => Dart_CObject());
}
