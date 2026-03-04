import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../controllers/movie_controller.dart';
import '../../../../core/widgets/movie_card.dart';
import '../../../domain/entities/movie_entity.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final MovieController _controller = GetIt.I.get<MovieController>();
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: _isSearching
            ? TextField(
          controller: _searchController,
          keyboardType: TextInputType.text,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Pesquisar filme...',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
          onChanged: (value) => _controller.filterMovies(value),
        )
            : const Text('MOVIE APP', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _controller.filterMovies('');
                }
              });
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<List<MovieEntity>>(
        valueListenable: _controller.movies,
        builder: (context, list, _) {
          if (list.isEmpty && _searchController.text.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }

          if (list.isEmpty && _searchController.text.isNotEmpty) {
            return const Center(
              child: Text('Nenhum filme encontrado.', style: TextStyle(color: Colors.white)),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) => MovieCard(movie: list[index]),
          );
        },
      ),
    );
  }
}