import 'package:dartz/dartz.dart';
import '../../entities/movie_entity.dart';
import '../../repositories/get_movies_repository.dart';
import 'get_movies_usecase.dart';

class GetMoviesUseCaseImp implements GetMoviesUseCase {
  final GetMoviesRepository _repository;
  GetMoviesUseCaseImp(this._repository);

  @override
  Future<Either<Exception, List<MovieEntity>>> call() async {
    return await _repository();
  }
}