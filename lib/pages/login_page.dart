import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores para capturar o texto
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Pega o tamanho da tela para cálculos responsivos
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // SingleChildScrollView: Evita erro de tela cortada quando o teclado abre
      body: SingleChildScrollView(
        child: Container(
          height: size.height, // Ocupa a altura toda para centralizar
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícone (Responsivo: 20% da altura da tela)
              Icon(
                Icons.people,
                size: size.height * 0.2,
                color: Colors.green, // Cor do tema
              ),

              const SizedBox(height: 30),

              // Campo de Login
              TextField(
                controller: _loginController,
                decoration: const InputDecoration(
                  labelText: 'Login',
                  prefixIcon: Icon(Icons.person), // Ícone dentro do input
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              // Campo de Senha
              TextField(
                controller: _passwordController,
                obscureText: true, // Esconde a senha
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock), // Ícone dentro do input
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),

              // Botão Padrão (ElevatedButton) com Estilo
              SizedBox(
                width: double.infinity, // Botão ocupa a largura total
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Apenas imprime no console por enquanto
                    debugPrint('Login: ${_loginController.text}');
                    debugPrint('Senha: ${_passwordController.text}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Cor de fundo (Background)
                    foregroundColor: Colors.white, // Cor do texto (Foreground)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Borda levemente arredondada
                    ),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}