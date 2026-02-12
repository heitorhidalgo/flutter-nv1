import 'package:flutter/material.dart';
import '../models/movies_model.dart';
import '../repositories/movies_repository.dart';

class MoviesController {
  final MoviesRepository _moviesRepository;

  // Lista que a tela "enxerga" (Pode ser filtrada)
  final ValueNotifier<List<MoviesModel>> movies = ValueNotifier<List<MoviesModel>>([]);

  // Lista Original (Cache/Backup) - Nunca perde dados
  List<MoviesModel>? _cachedMovies;

  final ValueNotifier<bool> loading = ValueNotifier<bool>(false);
  final ValueNotifier<String?> error = ValueNotifier<String?>(null);

  MoviesController(this._moviesRepository);

  Future<void> fetch() async {
    loading.value = true;
    error.value = null;
    try {
      final list = await _moviesRepository.getMovies();
      movies.value = list;
      _cachedMovies = list; // Salva o backup da lista original
    } catch (e) {
      error.value = 'Houve um problema ao carregar os filmes.';
    } finally {
      loading.value = false;
    }
  }

  // Método de Busca
  void onChanged(String value) {
    // Se não tiver cache, não faz nada
    if (_cachedMovies == null) return;

    // Obtém a lista original
    List<MoviesModel> list = _cachedMovies!;

    if (value.isEmpty) {
      // Se limpou a busca, restaura a lista original completa
      movies.value = list;
    } else {
      // Filtra a lista
      movies.value = list.where(
            (movie) => movie.toString().toLowerCase().contains(value.toLowerCase()),
      ).toList();
    }
  }
}