import 'package:flutter/material.dart';

import '../../models/joke_model.dart';

class RandomJokeData extends StatelessWidget {
  final Joke joke;

  const RandomJokeData({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            joke.setup,
            style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 10),
          Text(
            joke.punchline,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal
            ),
          ),
        ],
      ),
    );
  }
}
