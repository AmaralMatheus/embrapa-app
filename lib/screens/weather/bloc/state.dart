import 'package:weather/weather.dart';

class WeatherState {}
class InitialState extends WeatherState {}
class IdleState extends WeatherState {}
class LoadingState extends WeatherState {}
class LocatedState extends WeatherState {
  String location;
  Weather weather;
  List<Weather> forecasts;
  LocatedState({this.location, this.weather, this.forecasts});
}