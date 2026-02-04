import 'package:flutter/material.dart';
import 'package:flutter_nv1/controllers/home_controller.dart';
import 'package:flutter_nv1/repositories/home_repository_mock.dart'; // Importe a implementação Mock

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    // Injeção manual da dependência (Mock)
    // No futuro, você pode trocar por HomeRepositoryImp() que chama API real
    _controller = HomeController(HomeRepositoryMock());

    // Busca os dados ao iniciar
    _controller.fetch();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts (Mock)'),
      ),
      // ListenableBuilder para ouvir loading e posts
      body: ListenableBuilder(
        listenable: Listenable.merge([_controller.posts, _controller.loading]),
        builder: (context, _) {

          if (_controller.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_controller.posts.value.isEmpty) {
            return const Center(child: Text('Nenhum post encontrado'));
          }

          return ListView.separated(
            itemCount: _controller.posts.value.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, index) {
              final post = _controller.posts.value[index];
              return ListTile(
                title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(post.body),
                leading: CircleAvatar(child: Text(post.id.toString())),
              );
            },
          );
        },
      ),
    );
  }
}