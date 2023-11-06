import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_weather/weather.dart';
import 'package:mini_weather/weather_service.dart';

class WeatherPage extends StatefulWidget {
  final String apiKey;

  const WeatherPage({super.key, required this.apiKey});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late WeatherService _weatherService;
  Weather? _weather;
  String? _currentCity;

  @override
  void initState() {
    super.initState();
    _weatherService = WeatherService(apiKey: widget.apiKey);
    _getCurrentCity();
  }

  Future<void> _getCurrentCity() async {
    try {
      final status = await Geolocator.checkPermission();
      if (status == LocationPermission.denied) {
        final result = await Geolocator.requestPermission();
        if (result == LocationPermission.denied) {
          // Handle the case where the user denied permission
          if (kDebugMode) {
            print('Permission denied by user.');
          }
          return;
        }
      }

      if (status == LocationPermission.whileInUse ||
          status == LocationPermission.always) {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        setState(() {
          _currentCity = placemarks.first.locality ?? '';
          _fetchWeather(_currentCity!);
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting current city: $e');
      }
    }
  }

  Future<void> _fetchWeather(String cityName) async {
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching weather data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Weather 🌦️'),
        elevation: 0.0,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/icons/location.svg',
                      height: 24,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      _currentCity ?? 'Loading City...',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                if (_weather != null) ...[
                  Lottie.asset(
                    _getWeatherAnimation(_weather!.mainCondition),
                    width: 250,
                    height: 250,
                    fit: BoxFit.fill,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '${kelvinToCelsius(_weather!.temperature).toStringAsFixed(1)} °C',
                        style: const TextStyle(fontSize: 36),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${(_weather!.temperature * 9 / 5 - 459.67).toStringAsFixed(1)} °F',
                        style: const TextStyle(fontSize: 36),
                      ),
                    ],
                  ),
                  Text(
                    _weather!.mainCondition,
                    style: const TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getWeatherAnimation(String mainCondition) {
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'showers':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      default:
        return 'assets/sunny.json'; // Default animation
    }
  }

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15; // Formula to convert Kelvin to Celsius
  }
}
