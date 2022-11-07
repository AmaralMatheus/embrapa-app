import 'package:flutter/material.dart';
import '../../colors.dart';

// ignore: must_be_immutable
class CustomInput extends StatelessWidget {
  String label;
  TextEditingController controller;

  CustomInput({this.label, this.controller});

  Widget build(BuildContext context) => Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal:20),
        child: Text(this.label ?? '', style: TextStyle(
          color: WidgetsBinding.instance.window.platformBrightness == Brightness.light ? Palette.primary : Colors.white
        ))
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal:20),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1, color: WidgetsBinding.instance.window.platformBrightness == Brightness.light ? Palette.primary : Colors.white)
        ),
        child: TextFormField(
          controller: this.controller,
          decoration: InputDecoration(
            border: InputBorder.none
          ),
        ),
      )
    ]
  );
}