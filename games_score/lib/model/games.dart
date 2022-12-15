import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//https://javiercbk.github.io/json_to_dart/
//per generar les clases

Future<Game> fetchAlbum(String title) async {
  final response = await http.get(Uri.parse(
      'https://www.cheapshark.com/api/1.0/games?title=${title}&limit=60&exact=0')); // ES POT CAMBIAR EL ID "X8sebHhbc1Ga0dTkgg59WgyM506af9oNZZJLU9uSrX8%3D"

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Game.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Game {
  GameInfo? gameInfo;

  Game({this.gameInfo});

  Game.fromJson(Map<String, dynamic> json) {
    gameInfo = json['gameInfo'] != null
        ? new GameInfo.fromJson(json['gameInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gameInfo != null) {
      data['gameInfo'] = this.gameInfo!.toJson();
    }
    return data;
  }
}

class GameInfo {
  String? storeID;
  String? gameID;
  String? name;
  String? steamAppID;
  String? salePrice;
  String? retailPrice;
  String? steamRatingText;
  String? steamRatingPercent;
  String? steamRatingCount;
  String? metacriticScore;
  String? metacriticLink;
  int? releaseDate;
  String? publisher;
  String? steamworks;
  String? thumb;

  GameInfo(
      {this.storeID,
      this.gameID,
      this.name,
      this.steamAppID,
      this.salePrice,
      this.retailPrice,
      this.steamRatingText,
      this.steamRatingPercent,
      this.steamRatingCount,
      this.metacriticScore,
      this.metacriticLink,
      this.releaseDate,
      this.publisher,
      this.steamworks,
      this.thumb});

  GameInfo.fromJson(Map<String, dynamic> json) {
    storeID = json['storeID'];
    gameID = json['gameID'];
    name = json['name'];
    steamAppID = json['steamAppID'];
    salePrice = json['salePrice'];
    retailPrice = json['retailPrice'];
    steamRatingText = json['steamRatingText'];
    steamRatingPercent = json['steamRatingPercent'];
    steamRatingCount = json['steamRatingCount'];
    metacriticScore = json['metacriticScore'];
    metacriticLink = json['metacriticLink'];
    releaseDate = json['releaseDate'];
    publisher = json['publisher'];
    steamworks = json['steamworks'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeID'] = this.storeID;
    data['gameID'] = this.gameID;
    data['name'] = this.name;
    data['steamAppID'] = this.steamAppID;
    data['salePrice'] = this.salePrice;
    data['retailPrice'] = this.retailPrice;
    data['steamRatingText'] = this.steamRatingText;
    data['steamRatingPercent'] = this.steamRatingPercent;
    data['steamRatingCount'] = this.steamRatingCount;
    data['metacriticScore'] = this.metacriticScore;
    data['metacriticLink'] = this.metacriticLink;
    data['releaseDate'] = this.releaseDate;
    data['publisher'] = this.publisher;
    data['steamworks'] = this.steamworks;
    data['thumb'] = this.thumb;
    return data;
  }
}
