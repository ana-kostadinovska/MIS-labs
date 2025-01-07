import 'package:flutter/material.dart';

class JokeTypeCardData extends StatelessWidget {
  final String type;

  const JokeTypeCardData({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          "${type[0].toUpperCase()}${type.substring(1)}",
          style: const TextStyle(
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
    );
  }
}
