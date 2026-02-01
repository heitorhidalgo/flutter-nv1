import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.purple.shade200,
      body: Center(
        child: ElevatedButton(
            onPressed: (){
              Navigator.of(context).pop();
        }, child: Text("Voltar para pagina anterior")),
      ),
    );
  }
}
