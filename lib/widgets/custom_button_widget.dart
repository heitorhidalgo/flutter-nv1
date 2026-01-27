import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool disable;
  final double? titleSize;

  const CustomButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.disable = false,
    this.titleSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disable ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.red;
          }
          if (states.contains(WidgetState.pressed)) {
            return Colors.blue;
          }
          return Colors.green;
        }),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(fontSize: titleSize),
        ),
      ),
      child: Text(title),
    );
  }
}