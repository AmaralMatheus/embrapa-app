import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc/state.dart';
import 'bloc/event.dart';
import 'bloc/repository.dart';
import '../../../models/weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository _repository = WeatherRepository();

  WeatherBloc(WeatherState initialState) : super(initialState);

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if(event == WeatherEvent.initializeEvent) yield* this._getWeatherData();
  }

  Stream<WeatherState> _getWeatherData() async* {
    yield LoadingState();
    dynamic data = await _repository.getLocationData();
    yield LocatedState(location: data['city'].toString(), weather: data['weather'], forecasts: data['forecast']);
  }
}