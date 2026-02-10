import 'package:dio/dio.dart';
import '../models/movies_model.dart';
import '../services/dio_service.dart';
import 'movies_repository.dart';

class MoviesRepositoryImp implements MoviesRepository {
  final DioService _dioService;

  MoviesRepositoryImp(this._dioService);

  @override
  Future<List<MoviesModel>> getMovies() async {
    try {
      var dio = _dioService.getDio();
      // Chama a API
      var response = await dio.get('/movie/popular');

      // Pega a lista 'results' de dentro do JSON
      var list = response.data['results'] as List;

      // Converte cada item da lista para um MoviesModel
      return list.map((e) => MoviesModel.fromJson(e)).toList();

    } on DioException catch (e) {
      print(e);
      throw Exception('Erro ao buscar filmes');
    }
  }
}