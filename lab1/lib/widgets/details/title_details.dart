import 'package:flutter/material.dart';

class TitleDetails extends StatelessWidget {
  final int id;
  final String name;
  const TitleDetails({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      label: Text(
        "${name[0].toUpperCase()}${name.substring(1)}",
        style: const TextStyle(fontSize: 28, color: Colors.black),
      ),
      avatar: CircleAvatar(
        backgroundColor: Colors.pink[100],
        child: Text(
            id.toString(),
            style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}
