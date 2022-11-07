import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  Widget title;
  Color color;
  Function function;

  CustomAppBar({this.title, this.color, this.function});

  Widget build(BuildContext build) => AppBar(
    automaticallyImplyLeading: false,
    title: this.title,
    backgroundColor: this.color,
    brightness: Brightness.dark,
    actions: [
      IconButton(icon: Icon(Icons.feedback), onPressed: () => function())
    ],
    leading: null,

  );
}