import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lab3/screens/home.dart';
import 'package:lab3/screens/login.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
  Future<String?> register(String email, String password, BuildContext context) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await flutterSecureStorage.write(key: 'email', value: email);
      await flutterSecureStorage.write(key: 'logged', value: 'true');
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()));
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login(String email, String password, BuildContext context) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      await flutterSecureStorage.write(key: 'email', value: email);
      await flutterSecureStorage.write(key: 'logged', value: 'true');
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) => Home()));
      });
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        return 'Invalid login credentials.';
      } else {
        return e.message;
      }
    }
    catch (e) {
      return e.toString();
    }
  }

  Future<void> logout(BuildContext context) async {
    await _firebaseAuth.signOut();
    await flutterSecureStorage.write(key: 'logged', value: 'false');
    await flutterSecureStorage.delete(key: 'email');
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  Future<String?> getEmail() async {
    String? email;
    try {
      email = await flutterSecureStorage.read(key: 'email');
      return email;
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      return e.message.toString();
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<bool> loggedIn() async {
    return await flutterSecureStorage.read(key: 'logged') == 'true';
  }
}
