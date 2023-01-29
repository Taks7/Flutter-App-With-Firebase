import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

//Aqui es on es redirigeix la pagina per puntuar els jocs amb les estrelles
//Cada valor de la estrella es pasa a String i s'envia a firebase
class details_screen extends StatefulWidget {
  const details_screen({Key? key}) : super(key: key);
  @override
  State<details_screen> createState() => _details_screenState();
}

String titleGame = "";

class _details_screenState extends State<details_screen> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void didChangeDependencies() {
    final string = ModalRoute.of(context)!.settings.arguments;
    titleGame = string.toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Rate:  " + titleGame,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Gameplay:  ",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: _ScoreAGame(
                    sendRating: (String totalrating) {
                      _db.collection("/${user.email!}/$titleGame/gameplay").add(
                        {
                          'rate': totalrating,
                          'date': Timestamp.now(),
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Art:  ",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: _ScoreAGame(
                    sendRating: (String totalrating) {
                      _db.collection("/${user.email!}/$titleGame/art").add(
                        {
                          'rate': totalrating,
                          'date': Timestamp.now(),
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Music:  ",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: _ScoreAGame(
                    sendRating: (String totalrating) {
                      _db.collection("/${user.email!}/$titleGame/music").add(
                        {
                          'rate': totalrating,
                          'date': Timestamp.now(),
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Price:  ",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: _ScoreAGame(
                    sendRating: (String totalrating) {
                      _db.collection("/${user.email!}/$titleGame/price").add(
                        {
                          'rate': totalrating,
                          'date': Timestamp.now(),
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Replayability:  ",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: _ScoreAGame(
                    sendRating: (String totalrating) {
                      _db
                          .collection(
                              "/${user.email!}/$titleGame/replayability")
                          .add(
                        {
                          'rate': totalrating,
                          'date': Timestamp.now(),
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your last Gameplay rate was:  ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                PrintLastRateGameplay(),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your last Art rate was:  ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                PrintLastRateArt(),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your last Music rate was:  ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                PrintLastRateMusic(),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your last Price rate was:  ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                PrintLastRatePrice(),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your last Replayability rate was:  ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                PrintLastRateReplayability(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PrintLastRateGameplay extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final _db = FirebaseFirestore.instance;
    final ratingPath = "/${user.email!}/$titleGame/gameplay";
    return StreamBuilder(
      stream: _db
          .collection(ratingPath)
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        final querySnap = snapshot.data!;
        final docs = querySnap.docs;

        if (docs.length == 0) {
          //Comprobem si hi ha algo dins de la llista
          return Text(
            "There is no last review",
            style: TextStyle(
              fontSize: 15,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          final rating = docs[0];
          return Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Text(
                  rating['rate'],
                  style: TextStyle(color: Colors.yellow, fontSize: 20),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class PrintLastRateArt extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final _db = FirebaseFirestore.instance;
    final ratingPath = "/${user.email!}/$titleGame/art";
    return StreamBuilder(
      stream: _db
          .collection(ratingPath)
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        final querySnap = snapshot.data!;
        final docs = querySnap.docs;

        if (docs.length == 0) {
          //Comprobem si hi ha algo dins de la llista
          return Text(
            "There is no last review",
            style: TextStyle(
              fontSize: 15,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          final rating = docs[0];
          return Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Text(
                  rating['rate'],
                  style: TextStyle(color: Colors.yellow, fontSize: 20),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class PrintLastRateMusic extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final _db = FirebaseFirestore.instance;
    final ratingPath = "/${user.email!}/$titleGame/music";
    return StreamBuilder(
      stream: _db
          .collection(ratingPath)
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        final querySnap = snapshot.data!;
        final docs = querySnap.docs;

        if (docs.length == 0) {
          //Comprobem si hi ha algo dins de la llista
          return Text(
            "There is no last review",
            style: TextStyle(
              fontSize: 15,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          final rating = docs[0];
          return Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Text(
                  rating['rate'],
                  style: TextStyle(color: Colors.yellow, fontSize: 20),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class PrintLastRatePrice extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final _db = FirebaseFirestore.instance;
    final ratingPath = "/${user.email!}/$titleGame/price";
    return StreamBuilder(
      stream: _db
          .collection(ratingPath)
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        final querySnap = snapshot.data!;
        final docs = querySnap.docs;

        if (docs.length == 0) {
          //Comprobem si hi ha algo dins de la llista
          return Text(
            "There is no last review",
            style: TextStyle(
              fontSize: 15,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          final rating = docs[0];
          return Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Text(
                  rating['rate'],
                  style: TextStyle(color: Colors.yellow, fontSize: 20),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class PrintLastRateReplayability extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final _db = FirebaseFirestore.instance;
    final ratingPath = "/${user.email!}/$titleGame/replayability";
    return StreamBuilder(
      stream: _db
          .collection(ratingPath)
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        final querySnap = snapshot.data!;
        final docs = querySnap.docs;

        if (docs.length == 0) {
          //Comprobem si hi ha algo dins de la llista
          return Text(
            "There is no last review",
            style: TextStyle(
              fontSize: 15,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          final rating = docs[0];
          return Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Text(
                  rating['rate'],
                  style: TextStyle(color: Colors.yellow, fontSize: 20),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class _ScoreAGame extends StatefulWidget {
  final void Function(String) sendRating;
  const _ScoreAGame({super.key, required this.sendRating});

  @override
  _ScoreAGameState createState() => _ScoreAGameState();
}

//https://pub.dev/packages/flutter_rating_bar
//per puntuar amb barra d'estrelles
class _ScoreAGameState extends State<_ScoreAGame> {
  String totalrating = "";
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      //initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        totalrating = rating.toString();
        widget.sendRating(totalrating);
      },
    );
  }
}
