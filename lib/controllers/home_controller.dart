import 'package:flutter/material.dart';
import 'package:flutter_nv1/models/post_model.dart';
import 'package:flutter_nv1/repositories/home_repository.dart';

class HomeController {
  final HomeRepository _repository;

  // Estado: Lista de posts
  final ValueNotifier<List<Post>> posts = ValueNotifier<List<Post>>([]);

  // Opcional: Estado de Loading
  final ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  // Injeção de dependência via construtor
  HomeController(this._repository);

  Future<void> fetch() async {
    loading.value = true;
    // Chama o repositório (não importa se é Mock ou API real)
    posts.value = await _repository.getList();
    loading.value = false;
  }

  void dispose() {
    posts.dispose();
    loading.dispose();
  }
}