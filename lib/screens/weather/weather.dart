import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'bloc/state.dart';
import 'bloc/event.dart';
import 'bloc.dart';
import '../../widgets/layout/scaffold.dart';
import '../../colors.dart';

class WeatherScreen extends StatefulWidget {
  _WeatherScreenState createState() => _WeatherScreenState();

}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherBloc _bloc = WeatherBloc(InitialState());

  @override
  void initState() {
    super.initState();
  }

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

  Widget build(BuildContext context) => CustomScaffold(
    index: 3,
    body: BlocBuilder(
      bloc: this._bloc,
      builder: (context, state) {
        String languageCode = Localizations.localeOf(context).languageCode;

        if (state is InitialState) {
          this._bloc.add(WeatherEvent.initializeEvent);
        }

        if(state is LocatedState) {
          String auxDate = 'start';
          return  ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  children: [
                    Text(state.weather.areaName.toString()),
                    Text(
                      state.weather.temperature.toString().substring(0,2) + '°',
                      style: TextStyle(
                        fontSize: 50
                      ),
                    ),
                    Icon(this.getIcon(state.weather.weatherDescription.toString()), color: Palette.primary, size: 50,),
                  ]
                )
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: state.forecasts.map((forecast) {
                  if(auxDate != DateFormat('EEEE', languageCode).format(forecast.date).toString()) {
                    print(auxDate);
                    auxDate = DateFormat('EEEE', languageCode).format(forecast.date).toString();
                    return Container( 
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(DateFormat('EEEE', languageCode).format(forecast.date).toString()),
                          ),
                          Row(children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.1,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(this.getIcon(forecast.weatherDescription.toString()), color: Palette.primary),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.125,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(forecast.temperature.toString().substring(0,2) + '°'),
                            )
                          ])
                        ]
                      )
                    );
                  }
                  return SizedBox();
                }).toList()
              )
            ]
          );
        }

        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Palette.primary
          )
        );
      }
    ),
  );
}