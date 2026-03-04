import 'package:flutter/material.dart';
import '../../../domain/entities/movie_entity.dart';

class DetailsPage extends StatelessWidget {
  final MovieEntity movie;
  const DetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 450,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: movie.id,
                    child: Image.network(movie.posterPath, fit: BoxFit.cover),
                  ),
                  // GRADIENTE: Cria o efeito de "sumir" no preto
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xFF000000)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Color(0xFFFFC107)),
                      const SizedBox(width: 8),
                      Text("${movie.voteAverage} | 2024", style: const TextStyle(fontSize: 18, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text("Sinopse", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
                  const SizedBox(height: 12),
                  Text(movie.overview, style: const TextStyle(fontSize: 16, height: 1.5, color: Color(0xFFE0E0E0))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}