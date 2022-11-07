import 'package:dio/dio.dart';
import 'package:weather/weather.dart';

import '../../../resources/api.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import '../../../models/weather.dart';

class WeatherRepository {
  String key = '856822fd8e22db5e1ba48c0e7d69844a';
  WeatherFactory _factory;

  Future<dynamic> getWeatherData(Coordinates coordinates) async {
    WeatherFactory _factory;
    String latitude = coordinates.latitude.toString();
    String longitude = coordinates.longitude.toString();
    
    queryWeather(latitude, longitude);
    queryForecast(latitude, longitude);
    return null;
  }

  Future<dynamic> getLocationData() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    dynamic weather = await this.queryWeather(_locationData.latitude, _locationData.longitude);
    dynamic forecast = await this.queryForecast(_locationData.latitude, _locationData.longitude);

    final coordinates = new Coordinates(_locationData.latitude, _locationData.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    var city = addresses.first.locality;
    return {
      'coordinates': coordinates,
      'address': "${first.addressLine}",
      'city': city,
      'weather': weather,
      'forecast': forecast
    };
  }

  Future<List<Weather>> queryForecast(lat, lon) async {
    _factory = WeatherFactory(key, language: Language.PORTUGUESE_BRAZIL);
    List<Weather> forecasts = await _factory.fiveDayForecastByLocation(lat, lon);
    return forecasts;
  }

  Future<Weather> queryWeather(lat, lon) async {
    _factory = WeatherFactory(key, language: Language.PORTUGUESE_BRAZIL);
    Weather weather = await _factory.currentWeatherByLocation(lat, lon);
    return weather;
  }
}
