import 'package:flutter/material.dart';
import 'package:lab2/widgets/jokeTypes/joke_types_grid.dart';

import '../services/api_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> jokeTypes = [];

  @override
  void initState() {
    super.initState();
    getJokeTypesFromAPI();
  }

  void getJokeTypesFromAPI() async {
      List<String> types = await ApiService.getJokeTypes();
      setState(() {
        jokeTypes = types;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        leading: IconButton(onPressed: () {
          Navigator.pushNamed(context, "/random_joke");
        },
            icon: const Icon(
              Icons.auto_awesome,
              color: Colors.black,
              size: 36
            )
        ),
        title: const Text(
            "211006",
            style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.bold
            )
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {},
              icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 24
              )
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: JokeTypesGrid(jokeTypes: jokeTypes),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Share',
        backgroundColor: Colors.pink[50],
        child: const Icon(Icons.share_rounded),
      ),
    );
  }
}