//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:games_score/widgets/favourite_button.dart';
import 'package:games_score/widgets/gameplay_points_button.dart';
import 'package:games_score/widgets/art_points_button.dart';
//import 'package:games_score/widgets/chat_title.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color(0xffd4ebdf),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(child: Container(color: Colors.black,),), //AQUI HAY QUE PONER LA IMAGEN DEL JUEGO SELECCIONADO
              Expanded(child: Container(color: Colors.greenAccent,),), //AQUI PONEMOS LA INFO DE METASCORE (NOMBRE, PRECIO, PUNTUACION)
              Expanded(child: Container(color: Colors.white,),), //AQUI PONEMOS LA DESCRIPCIÓN DEL JUEGO Y LA PUNTUACION DE ARTE Y GAMEPLAY
            ],
          ),
          Align(
           alignment: Alignment.bottomRight,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               Padding(
                 padding: EdgeInsets.all(8.0),
                 child: FavoriteButton(color: Colors.red,),
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

