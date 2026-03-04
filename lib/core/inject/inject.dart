import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../layers/data/datasources/get_movies_datasource.dart';
import '../../layers/data/datasources/remote/get_movies_remote_datasource_imp.dart';
import '../../layers/data/repositories/get_movies_repository_imp.dart';
import '../../layers/domain/repositories/get_movies_repository.dart';
import '../../layers/domain/usecases/get_movies/get_movies_usecase.dart';
import '../../layers/domain/usecases/get_movies/get_movies_usecase_imp.dart';
import '../../layers/presentation/controllers/movie_controller.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.instance;

    // Externos
    getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3')));

    // DataSources
    getIt.registerLazySingleton<GetMoviesDataSource>(() => GetMoviesRemoteDataSourceImp(getIt()));

    // Repositories
    getIt.registerLazySingleton<GetMoviesRepository>(() => GetMoviesRepositoryImp(getIt()));

    // UseCases
    getIt.registerLazySingleton<GetMoviesUseCase>(() => GetMoviesUseCaseImp(getIt()));

    // Controllers
    getIt.registerFactory<MovieController>(() => MovieController(getIt()));
  }
}