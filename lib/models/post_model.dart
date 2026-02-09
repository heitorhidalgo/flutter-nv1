class PostModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Factory moderno para converter JSON
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      userId: json['userId'] ?? 0, // Garante um valor default se for nulo
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }

  // Método auxiliar para debug (toString)
  @override
  String toString() {
    return 'PostModel(id: $id, title: $title)';
  }
}