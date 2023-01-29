import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class search_games extends StatefulWidget {
  const search_games({Key? key}) : super(key: key);

  @override
  State<search_games> createState() => _search_gamesState();
}
//We have used https://pub.dev/packages/icons_plus
//to add more icons

//We have used https://pub.dev/packages/flutter_animated_button
//for the animated button and we have also used
//https://pub.dev/packages/google_fonts for the different font

class _search_gamesState extends State<search_games> {
  String title = "put here the title of the game";
  TextEditingController controller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
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
            Padding(
              padding: EdgeInsets.all(12),
              child: AnimatedButton.strip(
                animatedOn: AnimatedOn.onHover,
                width: 200,
                height: 70,
                text: 'SEARCH',
                isReverse: true,
                selectedTextColor: Colors.white,
                stripTransitionType: StripTransitionType.LEFT_TO_RIGHT,
                selectedBackgroundColor: Colors.black,
                textStyle: GoogleFonts.nunito(
                    fontSize: 24,
                    letterSpacing: 5,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
                onPress: () {
                  title = controller.text;
                  Navigator.of(context).pushNamed(
                    '/game-screen',
                    arguments: title,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BottomSheet(
        builder: (BuildContext context) {
          return ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                backgroundColor: Colors.black),
            icon: Icon(BoxIcons.bx_arrow_back, size: 32, color: Colors.white),
            label: Text(
              "Sign Out",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              setState(() {
                Navigator.of(context).pushNamed(
                  '/login-screen',
                  //arguments: title,
                );
              });
            },
          );
        },
        onClosing: () {},
      ),
    );
  }
}
