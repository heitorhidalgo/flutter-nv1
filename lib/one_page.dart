import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Não esqueça do: flutter pub add http
import 'package:flutter_nv1/widgets/custom_button_widget.dart';

class OnePage extends StatefulWidget {
  const OnePage({super.key});

  @override
  State<OnePage> createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  // Estado: Lista de Posts
  final ValueNotifier<List<Post>> posts = ValueNotifier<List<Post>>([]);
  // Estado: Loading (Carregando)
  final ValueNotifier<bool> inLoader = ValueNotifier<bool>(false);

  @override
  void dispose() {
    // BOAS PRÁTICAS: Sempre descarte os notifiers ao sair da tela
    posts.dispose();
    inLoader.dispose();
    super.dispose();
  }

  // Lógica de chamar a API (Exatamente como na aula, mas com try/finally)
  Future<void> callApi() async {
    var client = http.Client();

    try {
      inLoader.value = true; // Ativa o loading

      // Simula um delay extra (só para ver o loading girando, igual no vídeo)
      await Future.delayed(const Duration(seconds: 2));

      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      // Decodifica e converte para Lista de Posts
      var decodedResponse = jsonDecode(response.body) as List;
      posts.value = decodedResponse.map((e) => Post.fromJson(e)).toList();

    } finally {
      client.close();
      inLoader.value = false; // Desativa o loading (mesmo se der erro)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ListenableBuilder: O substituto moderno do AnimatedBuilder para este caso
              ListenableBuilder(
                // Escuta os DOIS notifiers ao mesmo tempo (Merge)
                listenable: Listenable.merge([posts, inLoader]),
                builder: (context, _) {
                  // 1. Se estiver carregando, mostra o spinner
                  if (inLoader.value) {
                    return const CircularProgressIndicator();
                  }

                  // 2. Se a lista tiver dados, mostra a lista
                  if (posts.value.isNotEmpty) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(), // A rolagem fica no SingleChildScrollView pai
                      shrinkWrap: true, // Ocupa apenas o espaço necessário
                      itemCount: posts.value.length,
                      itemBuilder: (_, index) {
                        final post = posts.value[index];
                        return ListTile(
                          title: Text(post.title),
                          leading: Text(post.id.toString()),
                        );
                      },
                    );
                  }

                  // 3. Estado inicial (vazio)
                  return const Text(
                    'Nenhum post carregado',
                    style: TextStyle(fontSize: 20),
                  );
                },
              ),

              const SizedBox(height: 20),

              CustomButtonWidget(
                disable: false,
                onPressed: callApi, // Chama a função da API
                title: "Carregar API",
                titleSize: 18,
              ),

              const SizedBox(height: 20), // Espaço no final para não colar na borda
            ],
          ),
        ),
      ),
    );

  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Factory para converter JSON em Objeto (Seguro)
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] ?? 0,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Post(id: $id, title: $title)';
  }
}