import 'package:flutter/material.dart';

class BackButtonDetails extends StatelessWidget {
  const BackButtonDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.pop(context),
      tooltip: 'Go back',
      backgroundColor: Colors.pink[100],
      label: const Text(
          "Back",
          style: const TextStyle(
              fontSize: 18,
              color: Colors.white
          )
      ),
      icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.white
      ),
    );
  }
}
