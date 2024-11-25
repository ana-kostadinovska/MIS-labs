import 'package:flutter/material.dart';

class ClothesCardData extends StatelessWidget {
  final String image;
  final String name;

  const ClothesCardData({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Image.network(
                image,
                fit: BoxFit.contain,
                alignment: Alignment.bottomRight)
        ),
        const Divider(
          thickness: 1,
          indent: 15,
          endIndent: 15,
        ),
        Text(
          "${name[0].toUpperCase()}${name.substring(1)}",
          style: const TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}
