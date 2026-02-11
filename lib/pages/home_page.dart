import 'package:flutter/material.dart';
import '../controllers/movies_controller.dart';
import '../repositories/movies_repository_imp.dart';
import '../services/dio_service_imp.dart';
import '../models/movies_model.dart';
import '../widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MoviesController _controller = MoviesController(
    MoviesRepositoryImp(DioServiceImp()),
  );

  @override
  void initState() {
    super.initState();
    _controller.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No vídeo ele tira a AppBar e usa um layout customizado com SafeArea
      body: Padding(
        padding: const EdgeInsets.all(28.0), // Padding geral
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40), // Espaço para a barra de status (se não usar AppBar)

            // Título "Movies" grande
            Text(
              'Movies',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 20), // Espaço entre título e lista

            // Área da Lista
            // O ValueListenableBuilder deve envolver APENAS a parte que muda (a lista)
            Expanded(
              child: ValueListenableBuilder<bool>(
                valueListenable: _controller.loading,
                builder: (context, isLoading, child) {
                  if (isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ValueListenableBuilder<List<MoviesModel>>(
                    valueListenable: _controller.movies,
                    builder: (context, movies, child) {
                      return ListView.separated(
                        // Remove o padding interno da lista para alinhar com o título
                        padding: EdgeInsets.zero,
                        itemCount: movies.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 15), // Espaço entre cards
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          // Chama nosso widget customizado
                          return MovieCard(movie: movie);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}