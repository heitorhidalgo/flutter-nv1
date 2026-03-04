import 'package:flutter/material.dart';
import 'core/inject/inject.dart'; // Importe seu arquivo de injeção
import 'layers/presentation/ui/pages/movie_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Inject.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MOVIE APP',
      // PADRONIZAÇÃO: Configuração do tema escuro global
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF000000),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          elevation: 0,
          centerTitle: true,
        ),
        // Padronização da cor de destaque (Accent)
        colorScheme: const ColorScheme.dark(
          primary: Colors.red,
          secondary: Color(0xFFFFC107), // Amarelo Âmbar para ícones de nota
        ),
      ),
      home: const MoviePage(),
    );
  }
}