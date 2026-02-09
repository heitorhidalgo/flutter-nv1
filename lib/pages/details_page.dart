import 'package:flutter/material.dart';
import '../models/post_model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // RECUPERAÇÃO DOS ARGUMENTOS
    // Usamos 'as PostModel' para converter o argumento genérico (Object?) para nosso tipo.
    // O '!' em ModalRoute garante que estamos em uma rota válida.
    final PostModel args = ModalRoute.of(context)!.settings.arguments as PostModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Post'),
        backgroundColor: Colors.blue, // Apenas para exemplo visual
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView( // Adicionado para evitar erro de overflow em telas pequenas
        padding: const EdgeInsets.all(24.0), // Espaçamento geral
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha textos à esquerda
          children: [
            // Título estilizado
            Text(
              args.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic, // Estilo usado no vídeo
              ),
            ),
            const SizedBox(height: 24), // Espaçamento vertical moderno

            // Corpo do texto
            Text(
              args.body,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5, // Altura da linha para melhor leitura
              ),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 24),

            // Exibindo informações extras (ID e UserId)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Notícia ID: ${args.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Autor ID: ${args.userId}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}