import 'package:flutter/material.dart';
import '../../layers/domain/entities/movie_entity.dart';
import '../../layers/presentation/ui/pages/details_page.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailsPage(movie: movie))
      ),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E), // Superfície escura
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Image.network(
                  movie.posterPath,
                  width: 110,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        color: Color(0xFFE0E0E0), // Branco fosco
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFFFC107), size: 18), // Amarelo Âmbar
                        const SizedBox(width: 4),
                        Text(
                          movie.voteAverage.toString(),
                          style: const TextStyle(color: Color(0xFF9E9E9E), fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie.overview,
                      style: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 12), // Cinza médio
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
    );
  }
}