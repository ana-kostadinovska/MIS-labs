import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/joke_model.dart';
import '../../providers/joke_provider.dart';

class JokesData extends StatelessWidget {
  final List<Joke> jokes;

  const JokesData({super.key, required this.jokes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jokes.length,
      itemBuilder: (context, index) {
        final joke = jokes[index];

        return StatefulBuilder(
          builder: (context, setState) {
            return FutureBuilder<bool>(
              future: Provider.of<JokeProvider>(context, listen: false).isFavorite(joke),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error loading favorite status"),
                  );
                }

                final isFavorite = snapshot.data ?? false;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          joke.setup,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          joke.punchline,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isFavorite ? Colors.red : null,
                              ),
                              onPressed: () async {
                                await Provider.of<JokeProvider>(context, listen: false)
                                    .toggleFavorite(joke);
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
