import 'package:dio/dio.dart';
import 'package:embrapa/resources/api.dart';
import 'package:embrapa/widgets/layout/button.dart';
import 'package:embrapa/widgets/layout/input.dart';
import 'package:embrapa/widgets/layout/scaffold.dart';
import 'package:embrapa/widgets/layout/select.dart';
import 'package:flutter/material.dart';
import '../../colors.dart';

import 'dart:convert';

import 'package:flutter/services.dart';
import '../../resources/data.dart';

class CultivaresScreen extends StatefulWidget {
  _CultivarScreenState createState() => _CultivarScreenState();
}

class _CultivarScreenState extends State<StatefulWidget> {
  TextEditingController controller = TextEditingController();
  String tipoCultivar, potencialRamificacao, fundacao, acamamento;
  List cultivares = [];
  int tipoCultivarId, potencialRamificacaoId, fundacaoId, acamamentoId;
  bool filtering = false;
  RangeValues teorProteina = RangeValues(25, 75);
  RangeValues teorOleo = RangeValues(25, 75);
  RangeValues pesoMedio = RangeValues(250, 750);
  Api _api = Api();

  void clean() {
    setState(() {
      this.teorProteina = RangeValues(0, 100);
      this.teorOleo = RangeValues(0, 100);
      this.pesoMedio = RangeValues(0, 1000);
      this.tipoCultivar = null;
      this.potencialRamificacao = null;
      this.fundacao = null;
      this.acamamento = null;
      this.tipoCultivarId = null;
      this.potencialRamificacaoId = null;
      this.fundacaoId = null;
      this.acamamentoId = null;
    });
  }

  final formKey = GlobalKey<FormState>();
  // Future<void> readJson() async {
  //   final String response = await rootBundle.loadString('assets/data.json');
  //   final data = await json.decode(response);
  //   setState(() {
  //     _data = data["cultivar"];
  //   });
  //   print(_data);
  // }

  Widget getItem(item) {
    if (item != null) {
      return FlatButton(
        onPressed: () => Navigator.of(context).pushNamed('cultivar', arguments: {'cultivar': item}),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: 15
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[300],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(right: 15),
                child: Container(
                  alignment: Alignment(0.0,2.5),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/img/'+item['nome']+'.jpeg'),
                    radius: 60.0,
                  ),
                ),
              ),
              Text(item['nome'], style: TextStyle(color: Colors.black))
            ],
          ),
        ),
      );
    }
    return Container();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getDataFromAPI () async {
    dynamic response = await _api.get(endpoint: 'https://agrobit.tiproinformatica.com.br/api/v1/cultivar.php');
    response = json.decode(response);
    return response;
  }

  getData() async {
    data = await getDataFromAPI();
    setState(() {
      cultivares = [];
      cultivares = data['cultivar'].map((item) {
        if (item != null) {
          bool show = true;
          if(controller.text.isNotEmpty) {
            if (!item['nome'].contains(controller.text)) show = false;
          }
          if(this.tipoCultivar != null) {
            if (item['tipoCultivar'] != this.tipoCultivar) show = false;
          }
          if(this.potencialRamificacao != null) {
            if (item['potencialRamificacao'] != this.potencialRamificacao) show = false;
          }
          if(this.acamamento != null) {
            if (item['acamamento'] != this.acamamento) show = false;
          }
          if(this.fundacao != null) {
            if (item['fundacao'] != this.fundacao) show = false;
          }
          print(this.tipoCultivar == item['tipoCultivar']);
          if (show) {
            return item;
          }
          return null;
        }
      }).toList();
    });
  }

  Widget build(BuildContext context) => CustomScaffold(
    body: this.filtering ? Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        children: [
          SizedBox(height: 20,),
          Text('Filtrar Cultivares', style: TextStyle(color: Palette.primary, fontSize: 23),),
          SizedBox(height: 20,),
          CustomSelect(
            label: 'Tipo do cultivar',
            options: [{
                "label": "Convencional",
                "value": "1"
              },
              {
                "label": "RR",
                "value": "2"
              },
              {
                "label": "Intacta",
                "value": "3"
              }
            ],
            value: this.tipoCultivarId,
            getValue: (value) {
              setState(() {
                this.tipoCultivarId = value;
              });
              switch(value) {
                case 1:
                  this.tipoCultivar = 'CONVENCIONAL';
                  break;
                case 2:
                  this.tipoCultivar = 'RR';
                  break;
                case 3:
                  this.tipoCultivar = 'INTACTA';
                  break;
              }
            },
          ),
          CustomSelect(
            label: 'Potencial de ramificação',
            options: [{
                "label": "Alto",
                "value": "1"
              },
              {
                "label": "Médio",
                "value": "2"
              },
              {
                "label": "Baixo",
                "value": "3"
              }
            ],
            value: this.potencialRamificacaoId, 
            getValue: (value) {
              setState(() {
                this.potencialRamificacaoId = value;
              });
              switch(value) {
                case 1:
                  this.potencialRamificacao = 'ALTO';
                  break;
                case 2:
                  this.potencialRamificacao = 'MEDIO';
                  break;
                case 3:
                  this.potencialRamificacao = 'BAIXO';
                  break;
              }
            },
          ),
          CustomSelect(
            label: 'Fundação',
            options: [{
                "label": "Fundação Meridional",
                "value": "1"
              },
            ],
            value: this.fundacaoId,
            getValue: (value) {
              setState(() {
                this.fundacaoId = value;
                this.fundacao = "FUNDAÇÃO MERIDIONAL";
              });
            },
          ),
          CustomSelect(
            label: 'Acamamento',
            options: [
              {
                "label": "Resistente",
                "value": "1"
              },
              {
                "label": "Moderadamente Resistente",
                "value": "2"
              },
            ],
            value: this.acamamentoId,
            getValue: (value) {
              setState(() {
                this.acamamentoId = value;
                switch (value){
                  case 1:
                    this.acamamento = "RESISTENTE";
                    break;
                  case 2:
                    this.acamamento = "MODERADAMENTE RESISTENTE";

                }
              });
            },
          ),
          Container(
            child: Text('Teor médio proteína', style: TextStyle(color: Palette.primary),),
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
          RangeSlider(
            activeColor: Palette.primary,
            values: this.teorProteina,
            max: 100,
            min: 0,
            onChanged: (RangeValues value) {
              this.setState(() {
                this.teorProteina = value;
              });
            },
          ),
          Container(
            child: Text('Teor médio oleo', style: TextStyle(color: Palette.primary),),
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
          RangeSlider(
            activeColor: Palette.primary,
            values: this.teorOleo,
            max: 100,
            min: 0,
            onChanged: (RangeValues value) {
              this.setState(() {
                this.teorOleo = value;
              });
            },
          ),
          Container(
            child: Text('Peso médio 1000 sementes', style: TextStyle(color: Palette.primary),),
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
          RangeSlider(
            activeColor: Palette.primary,
            values: this.pesoMedio,
            max: 1000,
            min: 0,
            onChanged: (RangeValues value) {
              this.setState(() {
                this.pesoMedio = value;
              });
            },
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    this.filtering = false;
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.chevron_left),
                )
              ),
              GestureDetector(
                onTap: () {
                  this.clean();
                },
                child: Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.undo),
                ),
              ),
              CustomButton(
                width: MediaQuery.of(context).size.width * 0.5725,
                label: 'Filtrar',
                function: () {
                  setState(() {
                    this.filtering = false;
                  });
                  getData();
                }
              )
            ],
          )
        ]
      )
    ) : Stack(
      children: [
        ListView(
          padding: EdgeInsets.only(top:80),
          children: cultivares.isNotEmpty ? cultivares.map<Widget>((item) => this.getItem(item)).toList() : [Container()],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.only(left:20),
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Form(
            key: this.formKey,
            child: TextFormField(
              controller: this.controller,
              onChanged: (value) {
                this.setState(() {
                  getData();
                });
              },
              decoration: InputDecoration(
                hintText: 'Pesquisar cultivares..',
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search, color: Colors.grey,)
              ),
            ),
          ),
        )
      ],
    ),
    floatingActionButton: !this.filtering ? IconButton(
      icon: Icon(Icons.filter_alt_sharp),
      onPressed: () => setState(() {
        this.filtering = true;
      })
    ) : null,
    index: 1,
  );
}