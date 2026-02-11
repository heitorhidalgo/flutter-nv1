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
        child: ValueListenableBuilder<bool>(
          valueListenable: _controller.loading,
          builder: (context, isLoading, child) {

            // 1. SE ESTIVER CARREGANDO: MOSTRA LOTTIE
            if (isLoading) {
              return Center(
                child: Lottie.asset(
                  'assets/lottie.json',
                  width: 200, // Tamanho controlado
                  height: 200,
                ),
              );
            }

            // 2. SE CARREGOU: MOSTRA O CONTEÚDO (Título + Lista)
            // Usamos SingleChildScrollView + Column ou Expanded para layout
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Movies',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                // Lista de Filmes
                Expanded(
                  child: ValueListenableBuilder<List<MoviesModel>>(
                    valueListenable: _controller.movies,
                    builder: (context, movies, child) {
                      return ListView.separated(
                        padding: EdgeInsets.zero, // Remove padding extra
                        itemCount: movies.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 15),
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return MovieCard(movie: movie);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}