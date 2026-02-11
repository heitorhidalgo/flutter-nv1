import 'package:flutter/material.dart';
import '../models/movies_model.dart';

class MovieCard extends StatelessWidget {
  final MoviesModel movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15), // Arredonda o container
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. IMAGEM COM ARREDONDAMENTO APENAS NA ESQUERDA
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            child: Image.network(
              movie.posterPath,
              width: 150,
              height: double.infinity,
              fit: BoxFit.cover,

              // 2. LOADING BUILDER: Mostra progresso enquanto baixa a imagem
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox(
                  width: 150,
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },

              // 3. ERROR BUILDER: Se falhar (sem internet), mostra ícone
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  width: 150,
                  child: Center(
                    child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                  ),
                );
              },
            ),
          ),

          // CONTEÚDO DO TEXTO
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const Spacer(),
                  Text('Popularidade: ${movie.voteAverage}'),
                  const SizedBox(height: 10),
                  Text(
                    movie.overview,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}