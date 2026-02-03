import 'package:flutter/material.dart';
import 'package:flutter_nv1/controllers/login_controller.dart';
import 'package:flutter_nv1/widgets/custom_text_field_widget.dart';
import '../components/login/login_button_component.dart'; // Widget

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _controller = LoginController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people, size: size.height * 0.2, color: Colors.green),

              const SizedBox(height: 30),

              // Widget Genérico (Reutilizável)
              CustomTextFieldWidget(
                label: 'Login',
                controller: _loginController,
                prefixIcon: Icons.person,
              ),

              const SizedBox(height: 15),

              // Widget Genérico (Reutilizável)
              CustomTextFieldWidget(
                label: 'Senha',
                controller: _passwordController,
                obscureText: true,
                prefixIcon: Icons.lock,
              ),

              const SizedBox(height: 30),

              // Componente Específico (Conectado ao Controller)
              LoginButtonComponent(
                controller: _controller,
                onPressed: () async {
                  final valid = await _controller.auth(
                    _loginController.text,
                    _passwordController.text,
                  );

                  if (!mounted) return;

                  if (valid) {
                    Navigator.of(context).pushReplacementNamed('/home');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login ou senha inválidos'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}