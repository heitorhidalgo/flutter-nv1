import 'package:flutter/material.dart';
import '../services/prefs_services.dart';

class LoginController {
  // Notifier para controlar o loading (spinner)
  final ValueNotifier<bool> inLoader = ValueNotifier<bool>(false);

  // Método para simular o login
  Future<bool> auth(String login, String senha) async {
    inLoader.value = true;

    // Simula a demora da API (2 segundos)
    await Future.delayed(const Duration(seconds: 2));

    inLoader.value = false;

    // Validação "Hardcoded"
    if (login == 'admin' && senha == '123') {
      // Login Sucesso: Salva no disco
      await PrefsService.save(login);
      return true;
    } else {
      return false; // Falha
    }
  }

  void dispose() {
    inLoader.dispose();
  }
}