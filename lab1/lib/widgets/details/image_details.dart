import 'package:flutter/material.dart';

class ImageDetails extends StatelessWidget {
  final String image;

  const ImageDetails({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          image,
          fit: BoxFit.cover,
          height: 500,
          width: 450,
        ),
      ),
    );
  }
}
