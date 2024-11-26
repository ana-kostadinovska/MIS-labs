import 'package:flutter/material.dart';
import '../../models/clothes_model.dart';
import 'clothes_card.dart';

class ClothesGrid extends StatefulWidget {
  final List<Clothes> clothes;
  const ClothesGrid({super.key, required this.clothes});
  @override
  _ClothesGridState createState() => _ClothesGridState();
}
class _ClothesGridState extends State<ClothesGrid> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GridView.count(
      padding: const EdgeInsets.all(6),
      crossAxisCount: 2,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      semanticChildCount: 250,
      childAspectRatio: 0.75,
      physics: const BouncingScrollPhysics(),
      children: widget.clothes.map((clothes) =>
          ClothesCard(id: clothes.id, name: clothes.name, image: clothes.image, description: clothes.description, price: clothes.price,
          ),
      ).toList(),
    );
  }
}
