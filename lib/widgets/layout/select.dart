import 'package:flutter/material.dart';

import '../../colors.dart';

class CustomSelect extends StatefulWidget {
  String label, hint;
  Function getValue;
  List options = [
    {
      "label": "Label",
      "value": "value",
    },
    {
      "label": "Label",
      "value": "value",
    }
  ];
  var value;

  CustomSelect({
    this.label,
    this.value,
    this.options,
    this.getValue,
    this.hint: 'Selecione um filtro',
  });

  _CustomSelectState createState() => _CustomSelectState(
    label: this.label,
    value: this.value,
    options: this.options,
    getValue: this.getValue,
    hint: this.hint,
  );
}

class _CustomSelectState extends State<CustomSelect> {
  String label, hint;
  Function getValue;
  List options = [
    {
      "label": "Label",
      "value": "value",
    },
    {
      "label": "Label",
      "value": "value",
    }
  ];
  int value;

  _CustomSelectState({
    this.label,
    this.value,
    this.options,
    this.getValue,
    this.hint
  });


  initState() {
    return super.initState();
  }

  Widget build(BuildContext context) => Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left:20),
        child: Text(this.label ?? '', style: TextStyle(
          color: WidgetsBinding.instance.window.platformBrightness == Brightness.light ? Palette.primary : Colors.white
        ))
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal:20),
        margin: EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1, color: WidgetsBinding.instance.window.platformBrightness == Brightness.light ? Palette.primary : Colors.white)
        ),
        child: DropdownButton (
          value: this.value,
          onChanged: (value) {
            getValue(value);
          },
          hint: Text(hint),
          items:
          options.map((option) => DropdownMenuItem(
            child: Container(
              child: Text(option['label'])
            ),
            value: option['value'],
          )).toList()
        ),
      )
    ]
  );
}