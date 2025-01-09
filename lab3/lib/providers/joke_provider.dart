import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab3/models/joke_model.dart';
import 'package:lab3/services/api_services.dart';

class JokeProvider extends ChangeNotifier {
  bool _isObscure = true;

  bool get isObscure => _isObscure;

  final List<Joke> _favoriteJokes = [];
  List<Joke> get favoriteJokes => _favoriteJokes;

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference get favoritesJokesList => firebaseFirestore.collection('favorites');

  void toggleVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  Future<void> toggleFavorite (Joke joke) async {
    final user = firebaseAuth.currentUser;
    if (user == null) throw FirebaseAuthException(code: 'user-not-logged-in');
    if ( await isFavorite(joke)) {
      await favoritesJokesList.doc(user.uid).collection('userFavorites')
          .doc(joke.id).delete();
    } else {
      await favoritesJokesList.doc(user.uid).collection('userFavorites')
          .doc(joke.id).set({
        'joke': joke.id,
      });
    }
    notifyListeners();
  }

  Future<bool> isFavorite(Joke joke) async {
    final user = firebaseAuth.currentUser;
    if (user == null) throw FirebaseAuthException(code: 'user-not-logged-in');

    final jokeDoc = await favoritesJokesList.doc(user.uid).collection('userFavorites').doc(joke.id).get();
    return jokeDoc.exists;
  }

  Future<List<Joke>> getFavorites() async{
    final user = firebaseAuth.currentUser;
    if (user == null) throw FirebaseAuthException(code: 'user-not-logged-in');

    final document = await favoritesJokesList.doc(user.uid).collection('userFavorites').get();
    var jokeIds = await document.docs.map((toElement) => toElement['joke'] as String).toList();

    final List<Joke> favoriteJokes = [];
    for(var id in jokeIds){
      final joke = await ApiService.getJokeById(id);
      favoriteJokes.add(joke);
    }

    return favoriteJokes;
  }
}