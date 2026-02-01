import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_nv1/models/posts_model.dart'; // Importe seu model

class PostsController {
  // Os estados agora pertencem ao Controller
  final ValueNotifier<List<Post>> posts = ValueNotifier<List<Post>>([]);
  final ValueNotifier<bool> inLoader = ValueNotifier<bool>(false);

  // Lógica de chamar a API
  Future<void> callApi() async {
    var client = http.Client();
    try {
      inLoader.value = true;
      // Simulando delay de internet lenta
      await Future.delayed(const Duration(seconds: 2));

      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      var decodedResponse = jsonDecode(response.body) as List;
      posts.value = decodedResponse.map((e) => Post.fromJson(e)).toList();
    } finally {
      client.close();
      inLoader.value = false;
    }
  }

  // IMPORTANTE: Método para liberar memória quando a tela fechar
  void dispose() {
    posts.dispose();
    inLoader.dispose();
  }
}