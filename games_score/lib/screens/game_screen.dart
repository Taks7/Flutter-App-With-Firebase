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

//List of game names and urls we intend to add more games in the future for the request, due to the api being very case sensitive we need to be precise with the game if we want to get an specific one
List<String> games = [];
List<String> urlGames = [];

class _GameScreenState extends State<game_screen> {
  String titleGame = "";
  @override
  //To check if the game title has been updated
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
        leading: Expanded(
          child: GestureDetector(
            child: const Icon(Icons.arrow_back),
            onTap: () {
              games.clear();
              urlGames.clear();
              Navigator.pop(context);
            },
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 232, 224, 224),
      body: Stack(
        children: [
          Row(
            children: [
              //AQUI PONEMOS LA INFO DE METASCORE (NOMBRE, PRECIO, PUNTUACION)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 40,
                    ),
                    FutureBuilder<Game>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          urlGames.add(snapshot.data!.thumb!);
                          //Return image from url in case it does not work use error builder (thanks documentation xd)
                          return Image.network(
                            urlGames[0],
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return const Text(
                                  //Seems like some images of the api are banned or smh just an error that we got during development and now we have this to solve it
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
                    const SizedBox(
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
                              style: const TextStyle(
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
                    const Padding(
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
                      child: const Icon(Icons.star),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            //MARCAR COMO FAVORITO
                            Navigator.pushNamed(
                              context,
                              '/screenshoot-games',
                              arguments: games[0],
                            );
                          });
                        },
                        child: const Icon(
                          Icons.image,
                          color: Colors.black,
                        ),
                      ),
                    )
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
