//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:games_score/widgets/favourite_button.dart';
import 'package:games_score/model/games.dart';
import 'package:games_score/widgets/gameplay_points_button.dart';
import 'package:games_score/widgets/art_points_button.dart';
//import 'package:games_score/widgets/chat_title.dart';

class GameScreen extends StatelessWidget {
  Future<Game> futureAlbum = fetchAlbum();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color(0xffd4ebdf),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  child: FutureBuilder<Game>(
                    future: futureAlbum,
                    builder: (context, snapshot) {
                      String thumb =
                          snapshot.data!.gameInfo?.thumb ?? 'default';
                      if (snapshot.hasData) {
                        return Image.network(thumb);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ), //AQUI HAY QUE PONER LA IMAGEN DEL JUEGO SELECCIONADO
              Expanded(
                child: Container(
                  child: FutureBuilder<Game>(
                    future: futureAlbum,
                    builder: (context, snapshot) {
                      String name = snapshot.data!.gameInfo?.name ?? 'default';
                      if (snapshot.hasData) {
                        return Text(name);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                  color: Colors.greenAccent,
                ),
              ), //AQUI PONEMOS LA INFO DE METASCORE (NOMBRE, PRECIO, PUNTUACION)
              Expanded(
                child: Column(children: [
                  Container(
                    child: FutureBuilder<Game>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        String metacriticScore = snapshot.data!.gameInfo
                                ?.metacriticScore ?? //CAMBIAR AQUI
                            'default';
                        if (snapshot.hasData) {
                          return Text("Metacritic score: " + metacriticScore);
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                    color: Colors.greenAccent,
                  ),
                  Container(
                    child: FutureBuilder<Game>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        String steamRatingText = snapshot.data!.gameInfo
                                ?.steamRatingText ?? //CAMBIAR AQUI
                            'default';
                        if (snapshot.hasData) {
                          return Text("Steam review: " + steamRatingText);
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                    color: Colors.lightGreenAccent,
                  ),
                ]),
              ), //AQUI PONEMOS LA DESCRIPCIÓN DEL JUEGO Y LA PUNTUACION DE ARTE Y GAMEPLAY
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FavoriteButton(
                    color: Colors.red,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GameplayCounter(size: 100),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ArtCounter(size: 100),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
