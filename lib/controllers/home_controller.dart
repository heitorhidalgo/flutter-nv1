import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../repositories/home_repository.dart';

class HomeController {
  final HomeRepository _repository;

  // ESTADO 1: Sucesso (Lista de posts)
  final ValueNotifier<List<PostModel>> posts = ValueNotifier<List<PostModel>>([]);

  // ESTADO 2: Loading (Indicador de carregamento)
  final ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  // ESTADO 3: Erro (Para mostrar mensagem na tela se falhar)
  final ValueNotifier<String?> error = ValueNotifier<String?>(null);

  // Injeção de dependência via construtor
  HomeController(this._repository);

  Future<void> fetch() async {
    // 1. Prepara a casa: Liga o loading e limpa erros antigos
    loading.value = true;
    error.value = null;

    try {
      // 2. Tenta buscar os dados do repositório
      // Obs: Confirme se no seu repository o método chama 'getPosts' ou 'getList'
      posts.value = await _repository.getPosts();

    } catch (e) {
      // 3. Se der erro (sem internet, erro 404, etc), cai aqui
      error.value = 'Houve um problema ao carregar os posts. Tente novamente.';
      // Opcional: Logar o erro real no console para debug
      debugPrint(e.toString());
      posts.value = []; // Garante lista vazia em caso de erro

    } finally {
      // 4. O finally SEMPRE roda, dando certo ou errado.
      // É o lugar perfeito para desligar o loading.
      loading.value = false;
    }
  }

  // Não esquecer de limpar os notifiers para não vazar memória
  void dispose() {
    posts.dispose();
    loading.dispose();
    error.dispose();
  }
}