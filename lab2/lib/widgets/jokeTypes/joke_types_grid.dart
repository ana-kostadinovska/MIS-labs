import 'package:flutter/material.dart';
import 'package:lab2/widgets/jokeTypes/joke_type_card.dart';

class JokeTypesGrid extends StatefulWidget {
  final List<String> jokeTypes;
  const JokeTypesGrid({super.key, required this.jokeTypes});

  @override
  _JokeTypesGridState createState() => _JokeTypesGridState();
}
class _JokeTypesGridState extends State<JokeTypesGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(6),
      crossAxisCount: 2,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      semanticChildCount: 250,
      childAspectRatio: 0.9,
      physics: const BouncingScrollPhysics(),
      children: widget.jokeTypes.map((jokeType) =>
          JokeTypeCard(type: jokeType),
      ).toList(),
    );
  }
}
