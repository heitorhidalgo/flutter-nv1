import 'package:flutter/material.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/usecases/get_movies/get_movies_usecase.dart';

class MovieController {
  final GetMoviesUseCase _getMoviesUseCase;
  MovieController(this._getMoviesUseCase);

  // Lista que a UI observa
  final ValueNotifier<List<MovieEntity>> movies = ValueNotifier<List<MovieEntity>>([]);

  // Lista de backup para não perder os dados originais ao filtrar
  List<MovieEntity> _allMovies = [];

  Future<void> loadMovies() async {
    var result = await _getMoviesUseCase.call();

    result.fold(
          (error) => print(error),
          (success) {
        _allMovies = success;
        movies.value = success;
      },
    );
  }

  // MÉTODO DE BUSCA: Filtra a lista original e atualiza o ValueNotifier
  void filterMovies(String query) {
    if (query.isEmpty) {
      movies.value = _allMovies;
    } else {
      movies.value = _allMovies
          .where((movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}