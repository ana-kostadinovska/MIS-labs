import 'package:flutter/material.dart';
import 'package:lab2/screens/home.dart';
import 'package:lab2/screens/jokes.dart';
import 'package:lab2/screens/random_joke.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Clothes App',
      theme: ThemeData(primarySwatch: Colors.grey),
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/jokes": (context) => const Jokes(),
        "/random_joke": (context) => const RandomJoke(),
      },
    );
  }
}