import 'package:firebase_auth/firebase_auth.dart';
import 'package:games_score/model/games.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class search_games extends StatefulWidget {
  const search_games({Key? key}) : super(key: key);

  @override
  State<search_games> createState() => _search_gamesState();
}
//We have used https://pub.dev/packages/icons_plus
//to add more icons

class _search_gamesState extends State<search_games> {
  String title = "put here the title of the game";
  TextEditingController controller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(children: <Widget>[
          Row(
            children: [
              Text(
                'Game Searcher',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              SizedBox(
                width: 20,
              ),
              Icon(
                BoxIcons.bxs_game,
                color: Colors.amber,
              )
            ],
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(30)),
            icon: Icon(
              BoxIcons.bx_arrow_back,
              size: 22,
            ),
            label: Text(
              "Sign Out",
              style: TextStyle(fontSize: 18),
            ),
            onPressed: (() => FirebaseAuth.instance.signOut()),
          ),
          Row(
            children: [
              Text(
                "Logged in as: ${user.email!}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ]),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
            ),
            ElevatedButton(
              child: const Text("Search Game"),
              onPressed: () {
                title = controller.text;
                Navigator.of(context).pushNamed(
                  '/game-screen',
                  arguments: title,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
