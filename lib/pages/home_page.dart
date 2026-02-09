import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../repositories/home_repository_imp.dart';


class HomePage extends StatefulWidget {
  // Uso do super.key (Flutter moderno)
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Instanciando o repositório
  final HomeRepositoryImp _repository = HomeRepositoryImp();

  // Variável para armazenar o estado futuro
  late Future<List<PostModel>> _futurePosts;

  @override
  void initState() {
    super.initState();
    // Inicializa a busca dos dados
    _futurePosts = _repository.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumindo API com Dio'),
      ),
      // FutureBuilder gerencia os estados de Loading, Erro e Sucesso
      body: FutureBuilder<List<PostModel>>(
        future: _futurePosts,
        builder: (context, snapshot) {

          // Estado de Carregamento
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Estado de Erro
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          // Estado de Sucesso (mas lista vazia)
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum post encontrado.'));
          }

          // Estado de Sucesso com dados
          final posts = snapshot.data!;

          return ListView.separated(
            itemCount: posts.length,
            separatorBuilder: (_, __) => const Divider(), // O separador mencionado no vídeo
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(post.id.toString()),
                ),
                title: Text(
                  post.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(post.body),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Ação de clique mencionada para a próxima aula
                  print('Clicou no post ${post.id}');
                },
              );
            },
          );
        },
      ),
    );
  }
}