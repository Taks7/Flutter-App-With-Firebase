import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:games_score/model/games.dart';
import 'package:flutter/material.dart';

class details_screen extends StatefulWidget {
  const details_screen({Key? key}) : super(key: key);
  @override
  State<details_screen> createState() => _details_screenState();
}

class _details_screenState extends State<details_screen> {
  String titleGame = "";
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
      appBar: AppBar(title: Text("Rate  " + titleGame)),
      body: Column(
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
                    _db.collection("/rating").add(
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
                "WIP: More categories will be added in a future",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _db = FirebaseFirestore.instance;
    final messagesPath = "/rating";
    return StreamBuilder(
      stream: _db
          .collection(messagesPath)
          .orderBy("date", descending: true)
          .limit(200)
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final querySnap = snapshot.data!;
        final docs = querySnap.docs;
        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final message = docs[index];
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  color: Colors.white,
                  child: Text(message['text']),
                ),
              ],
            );
          },
        );
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
//per puntuar jocs
class _ScoreAGameState extends State<_ScoreAGame> {
  String totalrating = "";
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 3,
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
        print(rating);
      },
    );
  }
}
