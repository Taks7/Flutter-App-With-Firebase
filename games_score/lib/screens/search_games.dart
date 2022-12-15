import 'package:games_score/model/games.dart';
import 'package:flutter/material.dart';

class search_games extends StatefulWidget {
  const search_games({Key? key}) : super(key: key);

  @override
  State<search_games> createState() => _search_gamesState();
}

class _search_gamesState extends State<search_games> {
  String title = "put here the title of the game";
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("game")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              // b) Install the controller
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
