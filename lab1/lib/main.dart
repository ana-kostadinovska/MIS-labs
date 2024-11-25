import 'package:flutter/material.dart';
import 'package:lab1/screens/details.dart';
import 'package:lab1/screens/home.dart';

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
        "/details": (context) => const Details(),
      },
    );
  }
}