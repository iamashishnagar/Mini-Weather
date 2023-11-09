import 'package:flutter/material.dart';
import 'secrets.dart' as secrets;

class Constants {
  // Replace with your OpenWeatherMap API key
  static const String apiKey = secrets.apiKey;

  // Asset path for location icon
  static const String locationIcon = 'assets/icons/location.svg';

  // Asset paths for app theme color
  static const Color primaryColor = Color.fromARGB(255, 27, 52, 75);

  // Asset paths for weather animations
  static const String sunnyAnimation = 'assets/animations/sunny.json';
  static const String clear_sky_nightAnimation =
      'assets/animations/clear_sky_night.json';
  static const String cloudAnimation = 'assets/animations/cloud.json';
  static const String cloud_nightAnimation =
      'assets/animations/cloud_night.json';
  static const String few_cloudsAnimation = 'assets/animations/few_clouds.json';
  static const String rainAnimation = 'assets/animations/rain.json';
  static const String rain2Animation = 'assets/animations/rain2.json';
  static const String thunderstormAnimation =
      'assets/animations/thunderstorm.json';
  static const String snowAnimation = 'assets/animations/snow.json';
  static const String snow_nightAnimation = 'assets/animations/snow_night.json';
  static const String shower_rainAnimation =
      'assets/animations/shower_rain.json';
  static const String mistAnimation = 'assets/animations/mist.json';
  static const String mist_nightAnimation = 'assets/animations/mist_night.json';
}
