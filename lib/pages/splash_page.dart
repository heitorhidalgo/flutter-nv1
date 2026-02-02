import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Inicia a contagem ao abrir a tela
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    // Aguarda 3 segundos
    await Future.delayed(const Duration(seconds: 3));

    // VERIFICAÇÃO DE SEGURANÇA (Obrigatório no Flutter moderno)
    if (mounted) {
      // pushReplacementNamed: Troca a tela e não deixa voltar
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green.shade900,
        child: const Center(
          child: CircularProgressIndicator( // Loader
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}