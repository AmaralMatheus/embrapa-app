class WeatherModel {
  final DateTime date;
  final String temperature;
  final String weather;

  WeatherModel({
    this.date,
    this.temperature,
    this.weather,
  });

  WeatherModel.fromMap(Map<String, dynamic> map)
    : date = DateTime.parse(map['Date']),
      temperature = map['Temp'],
      weather = map['Weather'];

  Map<String, dynamic> toMap() => Map.from({
    "Date": date,
    "Temp": temperature,
    "Weather": weather
    });
}
