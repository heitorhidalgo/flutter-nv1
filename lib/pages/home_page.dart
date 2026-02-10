import 'package:flutter/material.dart';
import '../controllers/movies_controller.dart';
import '../repositories/movies_repository_imp.dart';
import '../services/dio_service_imp.dart';
import '../models/movies_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Injeção de Dependência Manual (Service -> Repo -> Controller)
  final MoviesController _controller = MoviesController(
    MoviesRepositoryImp(
      DioServiceImp(),
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        centerTitle: true,
      ),
      // Ouve o loading
      body: ValueListenableBuilder<bool>(
        valueListenable: _controller.loading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Ouve a lista de filmes
          return ValueListenableBuilder<List<MoviesModel>>(
            valueListenable: _controller.movies,
            builder: (context, movies, child) {
              return ListView.separated(
                itemCount: movies.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return ListTile(
                    leading: Image.network(
                      movie.posterPath,
                      width: 50, // Largura fixa para manter padrão
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.error),
                    ),
                    title: Text(movie.title),
                    subtitle: Text(
                      movie.overview,
                      maxLines: 2, // Limita texto a 2 linhas
                      overflow: TextOverflow.ellipsis, // Adiciona "..."
                    ),
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