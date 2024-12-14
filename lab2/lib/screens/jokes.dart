import 'package:flutter/material.dart';
import '../../models/joke_model.dart';
import '../widgets/jokes/jokes_data.dart';
import '../widgets/jokes/jokes_title.dart';

class Jokes extends StatelessWidget {
  const Jokes({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Joke> jokes = ModalRoute.of(context)!.settings.arguments as List<Joke>;
    final String jokeType = jokes.first.type;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        title: JokesTitle(type: jokeType),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: JokesData(jokes: jokes),
      ),
    );
  }
}
