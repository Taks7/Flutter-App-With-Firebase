
import 'package:flutter/material.dart';
import 'package:games_score/widgets/favourite_button.dart';
import 'package:games_score/model/games.dart';
import 'package:games_score/widgets/gameplay_points_button.dart';
import 'package:games_score/widgets/art_points_button.dart';


class game_screen extends StatefulWidget {
  game_screen({
    Key? key,
  }) : super(key: key);
  @override
  State<game_screen> createState() => _GameScreenState();
}

List<String> games = [];
class _GameScreenState extends State<game_screen> {


  String titleGame = "";

  @override
  void didChangeDependencies(){
    final  string = ModalRoute.of(context)!.settings.arguments;
    titleGame = string.toString();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    Future<Game> futureAlbum = fetchAlbum(titleGame);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pop();
            },
          ),
        ],
      ),
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
                      GameInfo? data = snapshot.data?.gameInfo;
                      // By default, show a loading spinner.
                      if (snapshot.hasData) {
                        return Text('${data?.name}');
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ),
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
