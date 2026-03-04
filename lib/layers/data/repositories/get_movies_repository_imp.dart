import 'package:dartz/dartz.dart'; // Importante para Right e Left
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/get_movies_repository.dart';
import '../datasources/get_movies_datasource.dart';

class GetMoviesRepositoryImp implements GetMoviesRepository {
  final GetMoviesDataSource _dataSource;
  GetMoviesRepositoryImp(this._dataSource);

  @override
  Future<Either<Exception, List<MovieEntity>>> call() async {
    try {
      final result = await _dataSource();
      return Right(result);
    } catch (e) {
      return Left(Exception('Erro no repositório'));
    }
  }
}