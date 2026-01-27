import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_nv1/widgets/custom_button_widget.dart';

class OnePage extends StatefulWidget {
  const OnePage({super.key});

  @override
  State<OnePage> createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  final ValueNotifier<int> valorAleatorio = ValueNotifier<int>(0);

  @override
  void dispose() {
    valorAleatorio.dispose();
    super.dispose();
  }

  Future<void> random() async {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      valorAleatorio.value = Random().nextInt(1000);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: valorAleatorio,
              builder: (_, value, __) {
                return Text(
                  "Valor é: $value",
                  style: const TextStyle(fontSize: 20),
                );
              },
            ),
            const SizedBox(height: 10),
            CustomButtonWidget(
              title: "Custom button",
              titleSize: 18,
              onPressed: () {
                debugPrint('Botão clicado');
                random();
              },
            ),
          ],
        ),
      ),
    );
  }
}