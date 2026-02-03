import 'package:flutter/material.dart';
import 'package:flutter_nv1/controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Instancia o Controller
  final LoginController _controller = LoginController();

  // Controladores de Texto
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Chave global para o SnackBar funcionar garantido (opcional, mas boa prática)
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _controller.dispose(); // Não esqueça de limpar o controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.people,
                size: size.height * 0.2,
                color: Colors.green,
              ),
              const SizedBox(height: 30),

              TextField(
                controller: _loginController,
                decoration: const InputDecoration(
                  labelText: 'Login',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),

              // O botão agora "escuta" o estado de loading do controller
              ListenableBuilder(
                listenable: _controller.inLoader,
                builder: (context, _) {
                  // Se estiver carregando, mostra o spinner
                  if (_controller.inLoader.value) {
                    return const CircularProgressIndicator(color: Colors.green);
                  }

                  // Se não, mostra o botão normal
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Chama a autenticação no controller
                        final valid = await _controller.auth(
                          _loginController.text,
                          _passwordController.text,
                        );

                        // Lógica de Sucesso ou Erro (na View)
                        if (!mounted) return; // Segurança

                        if (valid) {
                          // Sucesso: Vai para a Home
                          Navigator.of(context).pushReplacementNamed('/home');
                        } else {
                          // Falha: Mostra SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login ou senha inválidos'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Entrar', style: TextStyle(fontSize: 18)),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}