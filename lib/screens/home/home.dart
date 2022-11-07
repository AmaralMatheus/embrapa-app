import 'dart:convert';

import 'package:embrapa/widgets/layout/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:flutter/rendering.dart';
import 'package:zoom_widget/zoom_widget.dart';
import '../../colors.dart';
import '../../models/location.dart';
import '../../resources/data.dart';


class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<LocationModel> _data;
  MapShapeSource _mapSource;
  TextEditingController controller;
  List<dynamic> _availableMarkers;
  List<dynamic> markers = [
    {'nome': 'AL', 'latitude': -9.71, 'longitude': -35.73},
    {'nome': 'AM', 'latitude': -3.07, 'longitude': -61.66},
    {'nome': 'AP', 'latitude':   1.41, 'longitude': -51.77},
    {'nome': 'BA', 'latitude': -12.96, 'longitude': -38.51},
    {'nome': 'CE', 'latitude': -3.71, 'longitude': -38.54},
    {'nome': 'DF', 'latitude': -15.83, 'longitude': -47.86},
    {'nome': 'ES', 'latitude': -19.19, 'longitude': -40.34},
    {'nome': 'GO', 'latitude': -16.64, 'longitude': -49.31},
    {'nome': 'MA', 'latitude': -2.55, 'longitude': -44.30},
    {'nome': 'MT', 'latitude': -12.64, 'longitude': -55.42},
  ];
  List data;
  MapShapeLayerController _mapController = MapShapeLayerController();

  @override
  void initState() {
    _data = const <LocationModel>[
      LocationModel('Centro-Oeste', Colors.lightBlueAccent,'Centro-Oeste'),
      LocationModel('Nordeste', Colors.lightBlue,'Nordeste'),
      LocationModel('Norte', Colors.blueGrey,'Norte'),
      LocationModel('Sudeste', Colors.blueAccent,'Sudeste'),
      LocationModel('Sul', Colors.blue,'Sul'),
    ];

    _mapSource = MapShapeSource.asset(
      'assets/json/brasil.json',
      shapeDataField: 'NOME1',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].state,
      dataLabelMapper: (int index) => _data[index].stateCode,
      shapeColorValueMapper: (int index) => _data[index].color,
    );
    super.initState();
    this.loadJsonData();
  }

  @override
  void dispose() {
      super.dispose();
  }

  Future<String> loadJsonData() async {
      var jsonText = await rootBundle.loadString('assets/modelo.json');
      setState(() => data = json.decode(jsonText));
      return 'success';
  }

  void getMarkers(search) {
    _availableMarkers = markers.where((marker) => marker['nome'] == search).toList();
  }

  Widget build(BuildContext context) => CustomScaffold(
    body: Stack(
      children: [
        Zoom(
          backgroundColor: Colors.white,
          initZoom: 0,
          enableScroll: false,
          width: 1000,
          height: 1697.5,
          child: Container(
            height: 520,
            width: MediaQuery.of(context).size.width,
            child: SfMaps(
              layers: <MapShapeLayer>[
                MapShapeLayer(
                  source: _mapSource,
                  showDataLabels: true,
                  controller: _mapController,
                  initialMarkersCount:markers.length,
                  markerBuilder: (BuildContext context, int index){
                    return MapMarker(
                      latitude:markers[index]['latitude'],
                      longitude:markers[index]['longitude'],
                      size: Size(300, 300),
                      iconColor: Colors.red,
                      iconType: MapIconType.circle,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed('cultivar', arguments: {'cultivar': {
                          "idCultivar": "1",
                          "nome": "BRS 232",
                          "tipoCrescimento": "determinado",
                          "corFlor": "ROXA",
                          "corPubescencia": "CINZA",
                          "corHilo": "MARROM-CLARO",
                          "teorMedioProteina": "40.90",
                          "teorMedioOleo": "19.50",
                          "alturaPlanta": "67cm a 93cm",
                          "pesoMedio1000Sementes": "185.00",
                          "potencialRamificacao": "alto",
                          "lancamento": "2020/2021",
                          "fundacao": "FUNDAÇÃO MERIDIONAL",
                          "acamamento": "RESISTENTE",
                          "tipoCultivar": "CONVENCIONAL"
                        }, "isComparing": false}),
                        child: Icon(Icons.location_pin),
                      )
                    );
                  },
                  legend: MapLegend(MapElement.shape),
                  tooltipSettings: MapTooltipSettings(
                      color: Colors.grey[700],
                      strokeColor: Colors.white,
                      strokeWidth: 2),
                  strokeColor: Colors.white,
                  strokeWidth: 0.5,
                  shapeTooltipBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _data[index].stateCode,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                  dataLabelSettings: MapDataLabelSettings(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              Theme.of(context).textTheme.caption.fontSize)),
                ),
              ],
            ),
          ),
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
          child: TextField(
            controller: this.controller,
            onChanged: (value) {
              this.getMarkers(value);
            },
            decoration: InputDecoration(
              hintText: 'Pesquisar cultivares..',
              border: InputBorder.none,
              suffixIcon: Icon(Icons.search, color: Colors.grey,)
            ),
          ),
        )
      ]
    )
  );
}