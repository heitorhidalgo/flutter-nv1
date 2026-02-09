import 'package:flutter/material.dart';
import 'package:flutter_nv1/pages/details_page.dart';
import 'package:flutter_nv1/pages/home_page.dart';
import 'package:flutter_nv1/pages/splash_page.dart';
import 'package:flutter_nv1/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green, // Cor usada no vídeo
        useMaterial3: true, // Modernizando para Material 3
      ),
      // Rota inicial
      initialRoute: '/splash',
      // Mapa de Rotas
      routes: {
        '/splash': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/home': (_) => const HomePage(),
        '/details': (_) => const DetailsPage(), // Registrando a nova rota
      },
    );
  }
}