import 'package:flutter/material.dart';
import 'package:flutter_nv1/widgets/custom_button_widget.dart';

class OnePage extends StatelessWidget {
  const OnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButtonWidget(
          title: "Custom button",
          titleSize: 18,
          disable: false,
          onPressed: () {
            debugPrint('Botão clicado');
          },
        ),
      ),
    );
  }
}