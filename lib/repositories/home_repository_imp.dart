import 'package:dio/dio.dart';
import '../models/post_model.dart';
import 'home_repository.dart';


class HomeRepositoryImp implements HomeRepository {
  // Injeção de dependência é uma boa prática moderna,
  // mas aqui manteremos simples instanciando internamente ou recebendo no construtor.
  final Dio _dio = Dio();

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      // O Dio moderno já infere alguns tipos, mas é bom ser explícito
      final response = await _dio.get('https://jsonplaceholder.typicode.com/posts');

      // Verificação e conversão segura
      // No vídeo ele usa (response.data as List), aqui fazemos similar
      if (response.statusCode == 200) {
        final List<dynamic> list = response.data;
        return list.map((e) => PostModel.fromJson(e)).toList();
      } else {
        // Retorna lista vazia ou lança erro dependendo da sua regra de negócio
        return [];
      }
    } on DioException catch (e) {
      // DioException é a classe de erro atual (antigo DioError)
      print('Erro no Dio: ${e.message}');
      throw Exception('Falha ao carregar posts');
    }
  }
}