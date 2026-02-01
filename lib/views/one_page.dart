import 'package:flutter/material.dart';
import 'package:flutter_nv1/controllers/posts_controller.dart'; // Importe o controller
import 'package:flutter_nv1/widgets/custom_button_widget.dart';

class OnePage extends StatefulWidget {
  const OnePage({super.key});

  @override
  State<OnePage> createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  // Instanciamos o Controller
  final PostsController _controller = PostsController();

  @override
  void dispose() {
    // Agora só precisamos chamar o dispose do controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Escuta os notifiers que estão DENTRO do controller
              ListenableBuilder(
                listenable: Listenable.merge([_controller.posts, _controller.inLoader]),
                builder: (context, _) {
                  // Acesso via _controller
                  if (_controller.inLoader.value) {
                    return const CircularProgressIndicator();
                  }

                  if (_controller.posts.value.isNotEmpty) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _controller.posts.value.length,
                      itemBuilder: (_, index) {
                        final post = _controller.posts.value[index];
                        return ListTile(
                          title: Text(post.title),
                          leading: Text(post.id.toString()),
                        );
                      },
                    );
                  }

                  return const Text(
                    'Nenhum post carregado',
                    style: TextStyle(fontSize: 20),
                  );
                },
              ),

              const SizedBox(height: 20),

              CustomButtonWidget(
                disable: false,
                // Ação do botão chama o método do controller
                onPressed: () => _controller.callApi(),
                title: "Carregar API",
                titleSize: 18,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}