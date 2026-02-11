import 'package:flutter/material.dart';
import '../models/movies_model.dart';

class MovieCard extends StatelessWidget {
  final MoviesModel movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Altura fixa definida no vídeo
      decoration: BoxDecoration(
        color: Colors.black12, // Cor de fundo leve
        borderRadius: BorderRadius.circular(15), // Borda arredondada no card
      ),
      child: Row(
        children: [
          // IMAGEM (Poster)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            child: Image.network(
              movie.posterPath,
              width: 150, // Largura da imagem
              height: double.infinity, // Ocupa toda a altura do pai (200)
              fit: BoxFit.cover, // Cobre o espaço sem distorcer
              // Tratamento de Erro na Imagem
              errorBuilder: (_, __, ___) => Container(
                width: 150,
                color: Colors.grey,
                child: const Icon(Icons.broken_image, size: 50),
              ),
              // Tratamento de Loading (Opcional, mas recomendado)
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const SizedBox(
                  width: 150,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),

          // CONTEÚDO (Texto)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis, // Adiciona "..." se for grande
                    maxLines: 2,
                  ),

                  const Spacer(), // Empurra o conteúdo abaixo para o fim

                  // Avaliação
                  Text('Avaliação: ${movie.voteAverage}'),

                  const SizedBox(height: 10),

                  // Descrição curta (Overview)
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