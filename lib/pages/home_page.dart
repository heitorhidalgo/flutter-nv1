import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';
import '../models/post_model.dart';
import '../repositories/home_repository_imp.dart';
import '../services/prefs_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1. Instanciamos o Controller (passando o repositório para ele)
  final HomeController _controller = HomeController(HomeRepositoryImp());

  @override
  void initState() {
    super.initState();
    // 2. Chamamos o método fetch() para buscar os dados assim que a tela abre
    _controller.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // 1. Limpa os dados do disco
              await PrefsService.logout();

              // 2. Redireciona para o Login e remove todas as telas anteriores da pilha
              // (Isso impede que o usuário clique em "Voltar" e retorne para a Home)
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
              }
            },
          )
        ],
      ),
      // 3. O ValueListenableBuilder ouve as mudanças no 'loading' do controller
      body: ValueListenableBuilder<bool>(
        valueListenable: _controller.loading,
        builder: (context, isLoading, child) {

          // Se estiver carregando, mostra o spinner
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 4. Se não estiver carregando, ouve a lista de 'posts'
          return ValueListenableBuilder<List<PostModel>>(
            valueListenable: _controller.posts,
            builder: (context, posts, child) {

              // Se a lista estiver vazia (opcional: exibir mensagem)
              if (posts.isEmpty) {
                return const Center(child: Text('Nenhum post encontrado'));
              }

              // Constrói a lista
              return ListView.separated(
                itemCount: posts.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final post = posts[index];

                  return ListTile(
                    leading: CircleAvatar(
                      // Exibe o ID (convertendo para String)
                      child: Text(post.id.toString()),
                    ),
                    title: Text(
                      post.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(post.body), // Exibe o corpo do post
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // 5. NAVEGAÇÃO: Passando o objeto 'post' inteiro como argumento
                      Navigator.of(context).pushNamed(
                        '/details',
                        arguments: post,
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}