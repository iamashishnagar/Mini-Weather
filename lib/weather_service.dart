import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mini_weather/weather.dart';

class WeatherService {
  final String apiKey;

  WeatherService({required this.apiKey});

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
