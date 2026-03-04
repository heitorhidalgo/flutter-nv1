import '../../domain/entities/movie_entity.dart';

class MovieDto extends MovieEntity {
  MovieDto({
    required super.id,
    required super.title,
    required super.posterPath,
    required super.voteAverage,
    required super.overview,
  });

  factory MovieDto.fromMap(Map<String, dynamic> map) {
    return MovieDto(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      // CORREÇÃO: Adicionando a URL base do TMDB aqui no DTO
      posterPath: map['poster_path'] != null
          ? "https://image.tmdb.org/t/p/w500${map['poster_path']}"
          : '',
      voteAverage: (map['vote_average'] as num).toDouble(),
      overview: map['overview'] ?? 'Sem sinopse disponível.',
    );
  }
}