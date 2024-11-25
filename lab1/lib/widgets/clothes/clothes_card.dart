import 'package:flutter/material.dart';
import '../../models/clothes_model.dart';
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
        borderRadius: BorderRadius.circular(10),
        enableFeedback: true,
        splashColor: Colors.grey[600],
        onTap: () => {
          Navigator.pushNamed(
              context, "/details",
              arguments: Clothes(id: id, name: name, image: image, description: description, price: price)
          )
        },
        child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F1EF),
            borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
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
