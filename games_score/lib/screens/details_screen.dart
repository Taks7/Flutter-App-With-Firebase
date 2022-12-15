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
  void didChangeDependencies(){
    final  string = ModalRoute.of(context)!.settings.arguments;
    titleGame = string.toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Review")),
      body: Center(
        child: Text(titleGame),
        ),
    );
  }
}