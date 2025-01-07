import 'package:flutter/material.dart';
import '../models/joke_model.dart';
import '../services/api_services.dart';
import '../widgets/randomJoke/random_joke_data.dart';

class RandomJoke extends StatefulWidget {
  const RandomJoke({super.key});

  @override
  State<RandomJoke> createState() => _RandomJokeState();
}

class _RandomJokeState extends State<RandomJoke> {
  Joke randomJoke = Joke(id: 0, type: "", setup: "", punchline: "");

  @override
  void initState() {
    super.initState();
    getRandomJokeFromAPI();
  }

  void getRandomJokeFromAPI() async {
    Joke joke = await ApiService.getRandomJoke();
    setState(() {
      randomJoke = joke;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        title: const Text(
            "Random joke of the day",
            style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold
            )
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RandomJokeData(joke: randomJoke),
          ],
        ),
      ),
    );
  }
}
