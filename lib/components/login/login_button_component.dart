import 'package:flutter/material.dart';
import 'package:flutter_nv1/controllers/login_controller.dart';

class LoginButtonComponent extends StatelessWidget {
  final LoginController controller;
  final VoidCallback onPressed; // Recebe a ação de fora

  const LoginButtonComponent({
    super.key,
    required this.controller,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller.inLoader,
      builder: (context, _) {
        if (controller.inLoader.value) {
          return const Center(child: CircularProgressIndicator(color: Colors.green));
        }

        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Entrar', style: TextStyle(fontSize: 18)),
          ),
        );
      },
    );
  }
}