import 'package:flutter/material.dart';
import 'weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String apiKey = 'f527c7539329312237a3e58b621be5f5';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Weather 🌦️',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(apiKey: apiKey),
    );
  }
}
