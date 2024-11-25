import 'package:flutter/material.dart';

class TitleDetails extends StatelessWidget {
  final int id;
  final String name;
  const TitleDetails({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: Colors.pink[100],
          child: Text(
            id.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "${name[0].toUpperCase()}${name.substring(1)}",
            style: const TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }
}
