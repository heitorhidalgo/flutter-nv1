import 'package:flutter/material.dart';
import '../services/prefs_services.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    // Inicia a verificação assim que a tela abre
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    // Wait.wait permite esperar 2 coisas ao mesmo tempo:
    // 1. A animação da Splash (pelo menos 2 segundos para não piscar)
    // 2. A verificação no disco se o usuário está logado
    final results = await Future.wait([
      PrefsService.isAuth(), // Retorna bool
      Future.delayed(const Duration(seconds: 2)), // Delay visual
    ]);

    // O resultado do isAuth está no índice 0
    final bool isAuth = results[0] as bool;

    if (mounted) { // Verifica se a tela ainda existe antes de navegar
      if (isAuth) {
        // Se está logado, vai direto para Home, removendo a Splash da pilha
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Se não, vai para o Login
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade900,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}