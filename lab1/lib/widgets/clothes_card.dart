import 'package:flutter/material.dart';
import '../models/clothes_model.dart';
import 'clothes_card_data.dart';

class ClothesCard extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;

  const ClothesCard({super.key, required this.id, required this.name, required this.image, required this.description, required this.price});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        enableFeedback: true,
        splashColor: Colors.grey[600],
        onTap: () => {
          Navigator.pushNamed(
              context, "/details",
              arguments: Clothes(id: id, name: name, image: image, description: description, price: price)
          )
        },
        child: Container(
          margin: const EdgeInsets.all(6.0),
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5), width: 2),
              borderRadius: BorderRadius.circular(10)
          ),
          child: ClothesCardData(
              image: image,
              name: name
          ),
        ),
      ),
    );
  }
}
