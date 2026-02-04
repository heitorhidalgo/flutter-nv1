import 'dart:convert';
import 'package:flutter/services.dart'; // Para rootBundle
import 'package:flutter_nv1/models/post_model.dart';
import 'package:flutter_nv1/repositories/home_repository.dart';

class HomeRepositoryMock implements HomeRepository {
  @override
  Future<List<Post>> getList() async {
    try {
      // Lê o arquivo JSON dos assets
      final value = await rootBundle.loadString('assets/data.json');

      // Decodifica a String para List<dynamic>
      List<dynamic> listJson = jsonDecode(value);

      // Converte para List<Post>
      return listJson.map((e) => Post.fromJson(e)).toList();
    } catch (e) {
      // Retorna lista vazia em caso de erro (ou relança, dependendo da estratégia)
      print('Erro ao carregar mock: $e');
      return [];
    }
  }
}