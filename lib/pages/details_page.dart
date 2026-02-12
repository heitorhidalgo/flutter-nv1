import 'package:flutter/material.dart';
import '../models/movies_model.dart';

class DetailsPage extends StatelessWidget {
  final MoviesModel movie;

  const DetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGEM GRANDE COM HERO
            // O Hero permite a animação de transição fluida
            Hero(
              tag: movie.id, // A TAG deve ser igual na origem e no destino
              child: Image.network(
                movie.posterPath,
                width: double.infinity, // Ocupa toda a largura
                height: MediaQuery.of(context).size.height * 0.55, // 55% da tela
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox(
                  height: 300,
                  child: Center(child: Icon(Icons.broken_image, size: 50)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Nota e Data (Row com Icones)
                  Row(
                    children: [
                      const Icon(Icons.star, size: 34, color: Colors.amber),
                      const SizedBox(width: 5),
                      Text(
                        movie.voteAverage.toStringAsFixed(1), // Ex: 8.5
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.date_range_sharp, size: 36, color: Colors.black87),
                      const SizedBox(width: 5),
                      // Exemplo estático, mas poderia vir do model se tivesse o campo data
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lançamento',
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            movie.releaseDate,
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  // Sinopse (Overview)
                  Text(
                    'Sinopse',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.overview.isNotEmpty ? movie.overview : 'Sem descrição disponível.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.5, // Espaçamento entre linhas
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}