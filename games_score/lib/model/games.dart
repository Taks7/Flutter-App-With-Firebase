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
    return Game.fromJson(jsonDecode(response.body)[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Game {
  String? gameID;
  String? steamAppID;
  String? cheapest;
  String? cheapestDealID;
  String? external;
  String? internalName;
  String? thumb;

  Game(
      {this.gameID,
      this.steamAppID,
      this.cheapest,
      this.cheapestDealID,
      this.external,
      this.internalName,
      this.thumb});

  Game.fromJson(Map<String, dynamic> json) {
    gameID = json['gameID'];
    steamAppID = json['steamAppID'];
    cheapest = json['cheapest'];
    cheapestDealID = json['cheapestDealID'];
    external = json['external'];
    internalName = json['internalName'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gameID'] = this.gameID;
    data['steamAppID'] = this.steamAppID;
    data['cheapest'] = this.cheapest;
    data['cheapestDealID'] = this.cheapestDealID;
    data['external'] = this.external;
    data['internalName'] = this.internalName;
    data['thumb'] = this.thumb;
    return data;
  }
}
