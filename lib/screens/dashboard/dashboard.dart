import 'dart:convert';

import 'package:embrapa/resources/api.dart';
import 'package:embrapa/screens/weather/bloc.dart';
import 'package:embrapa/screens/weather/bloc/event.dart';
import 'package:embrapa/screens/weather/bloc/state.dart';
import 'package:embrapa/widgets/layout/button.dart';
import 'package:embrapa/widgets/layout/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../resources/data.dart';
import '../../colors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DashboardScreen extends StatefulWidget {
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashboardScreen> {
  final storage = FlutterSecureStorage();
  Api _api = Api();
  List<dynamic> epocaSemeadura = [], destaques = [];
  DateTime date;
  bool show = false;
  dynamic user;

  getDataFromAPI () async {
    dynamic response = await _api.get(endpoint: 'https://embrapa.tiproinformatica.com.br/wp-json/api/cultivar');
    response = response;
    return response;
  }
  
  initData() async {
    data = await getDataFromAPI();
    await storage.write(key: 'data', value: data.toString());
    this.logged = await storage.read(key: 'user') != null;
    await data['epocaSemeadura'].forEach((epoca) {
      if (epocaSemeadura.where((e) => e['idCultivar'] == epoca['idCultivar']).isEmpty) {
        epocaSemeadura.add(epoca);
      }
    });
    await data['destaque'].forEach((destaque) {
      if (destaques.where((d) => d.toString() == destaque.toString()).isEmpty) {
        destaques.add(destaque);
      }
    });
    print(data);
  }

  initState() {
    initData();
    super.initState();
  }

  WeatherBloc _bloc = WeatherBloc(InitialState());
  bool logged = false;

  IconData getIcon(condition) {
    switch(condition) {
      case 'algumas nuvens':
        return Icons.cloud_outlined;
      case 'nublado':
        return Icons.cloud;
      case 'céu limpo':
        return Icons.wb_sunny;
      case 'nuvens dispersas':
        return Icons.cloud;
      default:
        return Icons.grain;
    }
  }
  List<Widget> content () {
    if (!this.logged) {
      return [
          Text('Você ainda não está autenticado na plataforma'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                label: 'Acessar',
                width: MediaQuery.of(context).size.width/3,
                function: () => {
                  setState(() {
                    this.logged = true;
                  })
                },
              ),
              CustomButton(
                label: 'Cadastrar',
                width: MediaQuery.of(context).size.width/3,
                function: () => {
                  Navigator.of(context).pushNamed('register')
                },
              )
            ],
          )
        ];
     } else {
      return  [
        GestureDetector(
          onTap: () => {
            setState(() {
              storage.delete(key: 'user');
              this.logged = false;
            })
          },
          child: Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.centerRight,
            child: Icon(Icons.exit_to_app),
          ),
        ),
        Container(
          width: 100,
          height: 100,
          child: Container(
            alignment: Alignment(0.0,2.5),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://www.tmffertilizantes.com.br/wp-content/uploads/2020/03/WhatsApp-Image-2020-04-07-at-18.06.44-3-1024x682-1.jpeg"
              ),
              radius: 60.0,
            ),
          ),
        ),
        SizedBox(height: 20),
        Text('Bem vindo, ' + 'Matheus' + '!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500)),
      ];
     }
  }
  
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    return CustomScaffold(
      index: 2,
      body: BlocBuilder(
        bloc: this._bloc,
        builder: (context, state) {
          String languageCode = Localizations.localeOf(context).languageCode;

          if (state is InitialState) {
            this._bloc.add(WeatherEvent.initializeEvent);
          }

          if (state is LocatedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    color: Colors.black12,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: this.content()
                      )
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed('weather'),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20,),
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.width * 0.475,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Palette.primary,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            children: [
                              Text(state.weather.areaName.toString(), style: TextStyle(color: Colors.white)),
                              Text(
                                state.weather.temperature.toString().substring(0,2) + '°',
                                style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white
                                ),
                              ),
                              Icon(this.getIcon(state.weather.weatherDescription.toString()), color: Colors.white, size: 50,),
                            ]
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          setState(() => {
                            show = !show
                          })
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.width * 0.475,
                          decoration: BoxDecoration(
                            color: Palette.primary,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Destaques para a região de ' + state.weather.areaName.toString(), style: TextStyle(color: Colors.white)),
                              SizedBox(height: 10),
                              Text('Ver destaques', style: TextStyle(color: Colors.white)),
                              SizedBox(height: 20),
                              Center(
                                child: show ? Icon(Icons.arrow_upward_rounded, color: Colors.white) : Icon(Icons.arrow_downward_rounded, color: Colors.white)
                              )
                            ],
                          )
                        )
                      )
                    ],
                  ),
                  Column(
                    children: show ? destaques.map<Widget>((destaque) => GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed('cultivar', arguments: {'cultivar': data['cultivar'].where((cultivar) => cultivar['idCultivar'] == destaque['idCultivar']).first}),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width * 0.925,
                        decoration: BoxDecoration(
                          color: Palette.primary,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['cultivar'].where((cultivar) => cultivar['idCultivar'] == destaque['idCultivar']).first['nome'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                            SizedBox(height: 10),
                            Text(destaque['destaque'].replaceAll('<br />', ''), style: TextStyle(color: Colors.white)),
                          ],
                        )
                      )
                    )).toList() : [ SizedBox() ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: MediaQuery.of(context).size.width * 0.925,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          children: [
                            TableCalendar(
                              locale: 'pt_BR',
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: date != null ? date : DateTime.now(),
                              calendarFormat: CalendarFormat.month,
                              onDaySelected: (selectedDay, focusedDay) => {
                                setState(() => {
                                  date = selectedDay
                                })
                              },
                              calendarBuilders: CalendarBuilders(
                                markerBuilder: (context, day, events) {
                                  if (epocaSemeadura.where((epoca) => epoca['idCultivar'] == '3' && epoca[DateFormat.MMM('pt_BR').format(day).toLowerCase() + DateFormat.d('pt_BR').format(day)] != null).isNotEmpty) {
                                    return Container(
                                      width: 4,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle
                                      ),
                                    );
                                  }
                                }
                              )
                            ),
                            SizedBox(height: 20,)
                          ]
                        )
                      ),
                    ],
                  ),
                  date != null ? Container(
                    child: Column(
                      children: epocaSemeadura.where((epoca) => epoca[DateFormat.MMM('pt_BR').format(date).toLowerCase() + DateFormat.d('pt_BR').format(date)] != null).toList().map<Widget>((epoca) => GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed('cultivar', arguments: {'cultivar': data['cultivar'].where((cultivar) => cultivar['idCultivar'] == epoca['idCultivar']).first}),
                        child: Container(
                          child: Container(
                            padding: EdgeInsets.all(15),
                            margin: EdgeInsets.only(bottom: 20),
                            width: MediaQuery.of(context).size.width * 0.925,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['cultivar'].where((cultivar) => cultivar['idCultivar'] == epoca['idCultivar']).first['nome'].toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                  epoca['nome'].toString()
                                ),
                                Text(
                                  epoca['altitude'].toString()
                                ),
                                Text(
                                  epoca['ciclo'].toString()
                                ),
                              ]
                            ),
                          ),
                        )
                      )).toList(),
                    ),
                  ) : SizedBox()
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Container(
                  //       margin: EdgeInsets.only(bottom: 20),
                  //       width: MediaQuery.of(context).size.width * 0.45,
                  //       height: MediaQuery.of(context).size.width * 0.45,
                  //       decoration: BoxDecoration(
                  //         color: Colors.red,
                  //         borderRadius: BorderRadius.circular(20)
                  //       ),
                  //     ),
                  //     Container(
                  //       margin: EdgeInsets.only(bottom: 20),
                  //       width: MediaQuery.of(context).size.width * 0.45,
                  //       height: MediaQuery.of(context).size.width * 0.45,
                  //       decoration: BoxDecoration(
                  //         color: Colors.red,
                  //         borderRadius: BorderRadius.circular(20)
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Palette.primary
            )
          );
        }
      )
    );
  }
}