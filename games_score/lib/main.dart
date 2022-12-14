import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:games_score/firebase_options.dart';
import 'package:games_score/screens/game_screen.dart';
//import 'package:games_score/screens/chat_list_screen.dart';
//import 'package:games_score/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Games Review",
      theme: ThemeData(primarySwatch: Colors.pink),
      initialRoute: '/game-screen',
      routes: {
        '/game-screen': (context) => GameScreen(),
        // '/chat-messages': (context) => ,
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
