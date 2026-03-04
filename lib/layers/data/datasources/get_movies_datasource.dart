import '../dtos/movie_dto.dart';

abstract class GetMoviesDataSource {
  Future<List<MovieDto>> call();
}