import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            // Título
            Text(
              'Movies',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // BARRA DE PESQUISA (NOVIDADE)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                // Chama o controller a cada letra digitada
                onChanged: _controller.onChanged,
                decoration: const InputDecoration(
                  hintText: 'Pesquisar filmes...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Conteúdo (Lottie ou Lista)
            Expanded(
              child: ValueListenableBuilder<bool>(
                valueListenable: _controller.loading,
                builder: (context, isLoading, child) {
                  if (isLoading) {
                    return Center(
                      child: Lottie.asset(
                        'assets/lottie.json',
                        width: 200,
                      ),
                    );
                  }

                  return ValueListenableBuilder<List<MoviesModel>>(
                    valueListenable: _controller.movies,
                    builder: (context, movies, child) {
                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: movies.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 15),
                        itemBuilder: (context, index) {
                          final movie = movies[index];
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