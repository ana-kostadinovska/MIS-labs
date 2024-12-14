import 'package:flutter/material.dart';

class JokesTitle extends StatelessWidget {
  final String type;

  const JokesTitle({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Text(
      "${type[0].toUpperCase()}${type.substring(1)} jokes",
      style: const TextStyle(
        fontSize: 30,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}