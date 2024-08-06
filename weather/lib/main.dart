import 'package:flutter/material.dart';
import 'package:weather/pages/weather_page.dart';

void main() {
  runApp(const MyWeather());
}

class MyWeather extends StatelessWidget {
  const MyWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WeatherPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

