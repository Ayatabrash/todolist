import 'package:flutter/material.dart';

// ignore: must_be_immutable
class buttontask extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  buttontask({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: const Color.fromARGB(255, 52, 152, 55),
      child: Text(text),
    );
  }
}
