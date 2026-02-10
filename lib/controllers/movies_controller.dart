import 'package:flutter/material.dart';
import '../models/movies_model.dart';
import '../repositories/movies_repository.dart';

class MoviesController {
  final MoviesRepository _moviesRepository;

  // Notifiers para controlar a tela
  final ValueNotifier<List<MoviesModel>> movies = ValueNotifier<List<MoviesModel>>([]);
  final ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  MoviesController(this._moviesRepository);

  Future<void> fetch() async {
    loading.value = true;
    try {
      movies.value = await _moviesRepository.getMovies();
    } catch (e) {
      print('Erro no controller: $e');
    } finally {
      loading.value = false;
    }
  }
}