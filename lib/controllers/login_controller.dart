import 'package:flutter/material.dart';

class LoginController {
  // Notifier para controlar o loading (spinner)
  final ValueNotifier<bool> inLoader = ValueNotifier<bool>(false);

  // Método para simular o login
  Future<bool> auth(String login, String password) async {
    inLoader.value = true;

    // Simula a demora da API (2 segundos)
    await Future.delayed(const Duration(seconds: 2));

    inLoader.value = false;

    // Validação "Hardcoded"
    if (login == 'admin' && password == '123') {
      return true; // Sucesso
    } else {
      return false; // Falha
    }
  }

  void dispose() {
    inLoader.dispose();
  }
}