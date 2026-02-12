import '../utils/api_utils.dart';

class MoviesModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double voteAverage;

  // --- NOVOS CAMPOS ---
  final String backdropPath; // Imagem de fundo (banner)
  final String originalTitle; // Título original
  final String originalLanguage; // Idioma original (en, pt, es)
  final String releaseDate; // Data de lançamento
  final double popularity; // Popularidade
  final int voteCount; // Quantidade de votos
  final bool adult; // Se é conteúdo adulto
  final bool video; // Se tem video
  final List<int> genreIds; // Lista de IDs dos gêneros

  MoviesModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    // --- NOVO NO CONSTRUTOR ---
    required this.backdropPath,
    required this.originalTitle,
    required this.originalLanguage,
    required this.releaseDate,
    required this.popularity,
    required this.voteCount,
    required this.adult,
    required this.video,
    required this.genreIds,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(), // Garante que é double

      // Tratamento da imagem do Poster
      posterPath: json['poster_path'] != null
          ? '${API.requestImg}${json['poster_path']}'
          : 'https://via.placeholder.com/150',

      // --- MAPEAMENTO DOS NOVOS CAMPOS ---

      // Backdrop (Banner horizontal) - Mesma lógica do poster
      backdropPath: json['backdrop_path'] != null
          ? '${API.requestImg}${json['backdrop_path']}'
          : 'https://via.placeholder.com/300x200', // Placeholder diferente para banner

      originalTitle: json['original_title'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      releaseDate: json['release_date'] ?? '', // Pode vir vazio
      popularity: (json['popularity'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      adult: json['adult'] ?? false,
      video: json['video'] ?? false,

      // Lista de IDs (Cuidado especial aqui!)
      // O List<dynamic> precisa ser convertido para List<int>
      genreIds: json['genre_ids'] != null
          ? List<int>.from(json['genre_ids'])
          : [],
    );
  }

  // Atualizei o toString para incluir o título original na busca também
  @override
  String toString() {
    return '$title $originalTitle $overview';
  }
}