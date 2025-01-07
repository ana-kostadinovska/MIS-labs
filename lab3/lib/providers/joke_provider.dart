import 'package:flutter/material.dart';
import 'package:lab3/models/joke_model.dart';

class JokeProvider extends ChangeNotifier {
  bool _isObscure = true;

  bool get isObscure => _isObscure;

  final List<Joke> _favoriteJokes = [];
  List<Joke> get favoriteJokes => _favoriteJokes;

  void toggleVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  void toggleFavorite(Joke joke) {
    if (_favoriteJokes.contains(joke)) {
      _favoriteJokes.remove(joke);
    } else {
      _favoriteJokes.add(joke);
    }
    notifyListeners();
  }

  bool isFavorite(Joke joke) {
    return _favoriteJokes.contains(joke);
  }
}