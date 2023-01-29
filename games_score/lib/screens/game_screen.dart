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
int gameCount = 0;

void UpdateGameCount(int ListLength)
{
  gameCount = ListLength;
}
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
    Future<List<Game>> futureAlbum = fetchAlbum(titleGame);
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: FutureBuilder<List<Game>>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    gameCount = snapshot.data!.length;
                    for(int i = 0; i<snapshot.data!.length;i++)
                      {
                        urlGames.add(snapshot.data![i].thumb!);
                        games.add(snapshot.data![i].external!);
                      }
                    return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context,index)=>GridTile(
                          child: Container(
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  //MARCAR COMO FAVORITO
                                  Navigator.pushNamed(
                                    context,
                                    '/details-games',
                                    arguments: games[index],
                                  );
                                });
                              },
                              onDoubleTap: (){
                                setState(() {
                                  Navigator.pushNamed(
                                    context,
                                    '/screenshoot-games',
                                    arguments: games[index],
                                  );
                                });
                              },
                              child: Image.network(
                                urlGames[index],
                                errorBuilder: (BuildContext context, Object exception,
                                    StackTrace? stackTrace) {
                                  return const Text(
                                    //Seems like some images of the api are banned or smh just an error that we got during development and now we have this to solve it
                                      'Your image could not be loaded :V');
                                },
                              ),
                            ),
                          ),
                        ),
                        );
                  }
                  else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
            ],
          ),
    );//AQUI PONEMOS LA INFO DE METASCORE (NOMBR
  }
}
