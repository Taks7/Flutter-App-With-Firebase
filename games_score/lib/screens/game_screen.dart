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
List<String> urlGames = [];

class _GameScreenState extends State<game_screen> {
  String titleGame = "";
  @override
  void didChangeDependencies() {
    final string = ModalRoute.of(context)!.settings.arguments;
    titleGame = string.toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Future<Game> futureAlbum = fetchAlbum(titleGame);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: [
          Row(
            children: [
              GestureDetector(
                child: Icon(Icons.arrow_back),
                onTap: () {
                  games.clear();
                  urlGames.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
      backgroundColor: Color.fromARGB(255, 232, 224, 224),
      body: Stack(
        children: [
          Row(
            children: [
              //AQUI PONEMOS LA INFO DE METASCORE (NOMBRE, PRECIO, PUNTUACION)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    FutureBuilder<Game>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          urlGames.add(snapshot.data!.thumb!);
                          return Image.network(
                            urlGames[0],
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return const Text(
                                  'Your image could not be loaded :V');
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Container(
                      child: FutureBuilder<Game>(
                        future: futureAlbum,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            games.add(snapshot.data!.external!);
                            return Text(
                              games[0],
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  ],
                ),
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
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          //MARCAR COMO FAVORITO
                          Navigator.pushNamed(
                            context,
                            '/details-games',
                            arguments: games[0],
                          );
                        });
                      },
                      child: Icon(Icons.star),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
