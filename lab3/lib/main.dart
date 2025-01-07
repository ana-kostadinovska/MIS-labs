import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lab3/providers/joke_provider.dart';
import 'package:lab3/screens/home.dart';
import 'package:lab3/screens/jokes.dart';
import 'package:lab3/screens/random_joke.dart';
import 'package:lab3/services/notifications_service.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationsService().initialize();

  runApp(
    ChangeNotifierProvider(
      create: (_) => JokeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Clothes App',
      theme: ThemeData(primarySwatch: Colors.grey),
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/jokes": (context) => const Jokes(),
        "/random_joke": (context) => const RandomJoke(),
      },
    );
  }
}