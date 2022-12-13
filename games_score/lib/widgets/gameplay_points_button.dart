import 'package:flutter/material.dart';

class GameplayCounter extends StatefulWidget {
  final double size;
  const GameplayCounter({super.key, required this.size});

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<GameplayCounter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          count++;
        });
      },
      onLongPress: () {
        setState(() {
          count--;
        });
      },
      child: Container(
        width: widget.size,
        decoration: BoxDecoration(
          color: Colors.lightGreenAccent,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(width: 25,),
            Icon(Icons.gamepad),
            SizedBox(width: 25,),
            Text("$count",
                style: TextStyle(
                  color: Colors.black,
                ))
          ],
        ),
      ),
    );
  }
}
