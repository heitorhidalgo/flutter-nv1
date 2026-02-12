import 'package:flutter/material.dart';
import '../models/movies_model.dart';
import '../pages/details_page.dart'; // Importe a página de detalhes

class MovieCard extends StatelessWidget {
  final MoviesModel movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    // Usamos Material e InkWell para dar o efeito de clique (ripple)
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // NAVEGAÇÃO
          // Usamos push para empilhar a página de detalhes
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailsPage(movie: movie), // Passa o objeto
              fullscreenDialog: true, // Opcional: Efeito de abrir "de baixo pra cima" (iOS style)
            ),
          );
        },
        child: Container(
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 20), // Margem lateral
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
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
              // HERO ANIMATION NA ORIGEM
              // Envolvemos o ClipRRect com Hero e a MESMA tag (movie.id)
              Hero(
                tag: movie.id,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  child: Image.network(
                    movie.posterPath,
                    width: 150,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const SizedBox(
                        width: 150,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                  ),
                ),
              ),

              // Conteúdo do Texto (igual ao anterior)
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Text('Nota: ${movie.voteAverage}'),
                      const SizedBox(height: 10),
                      Text(
                        movie.overview,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}