import 'package:flutter/material.dart';

import '../../services/api_services.dart';
import 'joke_type_card_data.dart';

class JokeTypeCard extends StatelessWidget {
  final String type;

  const JokeTypeCard({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        enableFeedback: true,
        splashColor: Colors.grey[600],
        onTap: () {
          ApiService.getJokesByType(type).then((jokes) {
            Navigator.pushNamed(context, "/jokes", arguments: jokes);
          });
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
          child: JokeTypeCardData(
              type: type
          ),
        ),
      ),
    );
  }
}
