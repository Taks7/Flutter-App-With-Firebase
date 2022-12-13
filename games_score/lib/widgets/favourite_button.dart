
import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final Color color;
  const FavoriteButton({super.key, required this.color});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          favorite = !favorite;
        });
      },
      backgroundColor: widget.color,
      child: Icon(
        favorite ? Icons.favorite : Icons.favorite_outline,
      ),
    );
  }
}
