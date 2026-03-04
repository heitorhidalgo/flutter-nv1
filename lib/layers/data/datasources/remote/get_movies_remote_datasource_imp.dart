import 'package:dio/dio.dart';
import '../../dtos/movie_dto.dart';
import '../get_movies_datasource.dart'; // Importação do contrato faltante

class GetMoviesRemoteDataSourceImp implements GetMoviesDataSource {
  final Dio _dio;
  GetMoviesRemoteDataSourceImp(this._dio);

  @override
  Future<List<MovieDto>> call() async {
    try {
      final response = await _dio.get('/movie/popular', queryParameters: {
        'api_key': 'd825bd8d81064b6592c89de67990a38c', // Corrigido para passar apenas a chave
        'language': 'pt-BR',
      });

      final list = (response.data['results'] as List)
          .map((e) => MovieDto.fromMap(e))
          .toList();

      return list;
    } catch (e) {
      throw Exception('Falha ao buscar filmes remotamente');
    }
  }
}