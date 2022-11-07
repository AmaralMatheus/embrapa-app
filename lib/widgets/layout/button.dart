import 'package:flutter/material.dart';
import '../../colors.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  String label;
  Function function;
  double width;
  CustomButton({this.label, this.function, this.width});

  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    width: this.width != null ? this.width : MediaQuery.of(context).size.width,
    child: FlatButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),
      color: Palette.primary,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 17.5),
        child: Center(
          child: Text(this.label, style: TextStyle(
            color: Colors.white
          ))
        )
      ),
      onPressed: () => function(),
    )
  );
}