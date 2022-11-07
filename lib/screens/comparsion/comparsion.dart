import 'package:embrapa/screens/cultivar/cultivar.dart';
import 'package:embrapa/widgets/layout/scaffold.dart';
import 'package:embrapa/widgets/layout/select.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../resources/data.dart';

class ComparsionScreen extends StatefulWidget {
  ComparsionScreenState createState() => ComparsionScreenState();
}

class ComparsionScreenState extends State<ComparsionScreen> {
  int cultivar1;
  int cultivar2;

  void initState() {
      print(data['cultivar'].where((cultivar) => cultivar['idCultivar'] == '3'));
  }

  Widget build(BuildContext context) => CustomScaffold(
    index: 4,
    body: SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 20
            ),
            child: CarouselSlider(
              options: CarouselOptions(height: 1500),
              items: [
                this.cultivar1 != null ? CultivarScreen(isComparing: true, cultivarSelecionado: data['cultivar'].firstWhere((cultivar) => cultivar['idCultivar'] == this.cultivar1.toString())) : null,
                this.cultivar2 != null ? CultivarScreen(isComparing: true, cultivarSelecionado: data['cultivar'].firstWhere((cultivar) => cultivar['idCultivar'] == this.cultivar2.toString())) : null
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 10),
                  child: CustomSelect(
                    hint: 'Selecione o primeiro cultivar',
                    label: 'Cultivar 1',
                    value: this.cultivar1,
                    getValue: (value) {
                      setState(() {
                        this.cultivar1 = value;
                        print(data['cultivar'][this.cultivar1-1]);
                        print(data['cultivar'].where((cultivar) => cultivar['idCultivar'] == this.cultivar1.toString()));
                      });
                    },
                    options: data['cultivar'].map((item) => {
                      "label": item["nome"],
                      "value": item["idCultivar"]
                    }).toList(),
                  )
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: CustomSelect(
                    hint: 'Selecione o primeiro cultivar',
                    label: 'Cultivar 2',
                    value: this.cultivar2, 
                    getValue: (value) {
                      setState(() {
                        this.cultivar2 = value;
                      });
                    },
                    options: data['cultivar'].map((item) => {
                      "label": item["nome"],
                      "value": item["idCultivar"]
                    }).toList(),
                  )
                )
              ],
            ),
          ),
        ]
      )
    )
  );
}