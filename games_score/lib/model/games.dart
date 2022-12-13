import 'dart:ui';

class GameInfo{
  String gameName;
  num likes;
  num favourites;
  num artPoints;
  num gamePlayPoints;
  String imageAsset;
  String gameDescription;
  GameInfo(this.gameName,this.likes,this.favourites,this.artPoints,this.gamePlayPoints,this.imageAsset,this.gameDescription);
}

class Game {
  List<GameInfo> infoGames;


  Game({
    this.infoGames = const[],

  });
}
