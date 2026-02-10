import '../utils/api_utils.dart';

class MoviesModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double voteAverage;

  MoviesModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      // Lógica para montar a URL completa da imagem
      posterPath: json['poster_path'] != null
          ? '${API.requestImg}${json['poster_path']}'
          : 'https://via.placeholder.com/150',
    );
  }
}