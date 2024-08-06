import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/service/weather_service.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //api
  final _weatherService = WeatherService('f31e4b1180075c3c5aa591d8360312ff');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get city
    String cityName = await _weatherService.getCurrentCity();
    //get weather
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    catch (e){
      print(e);
    }
    
  }
  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'anims/Sunny.json';

    switch(mainCondition.toLowerCase()) {
      case 'clouds':
      case 'haze':
      case 'mist':
      case 'smoke':
      case 'dust':
      case 'fog':
        return 'anims/Cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'anims/Rainy.json';
      case 'thunderstorm':
        return 'anims/Thunderstorm.json';
      case 'clear':
        return 'anims/Sunny.json';
      default:
        return 'anims/Sunny.json';
    }
  }

  //get bg
  Color getBackground(String? mainCondition) {
    if (mainCondition == null) return Colors.lightBlueAccent.withOpacity(1.0);

    switch(mainCondition.toLowerCase()) {
      case 'clouds':
      case 'haze':
      case 'mist':
      case 'smoke':
      case 'dust':
      case 'fog':
        return Colors.blueGrey.withOpacity(1.0);
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return Colors.blueGrey.withOpacity(1.0);
      case 'thunderstorm':
        return Colors.white30.withOpacity(1.0);
      case 'clear':
        return Colors.lightBlueAccent.withOpacity(1.0);
      default:
        return Colors.lightBlueAccent.withOpacity(1.0);
    }
  }


  //init state
  @override
  void initState(){
    super.initState();
    //fetch on startup
    _fetchWeather();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackground(_weather?.mainCondition),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            //cityname
            Text(_weather?.cityName ?? "loading city...",
              style: GoogleFonts.abel(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                )
              ),
              ),

            //anims
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),


            // temp
            Text('${_weather?.temp.round()}°C',
              style: GoogleFonts.abel(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                  )
              ),
            ),

            //Weaather conndition
            Text(_weather?.mainCondition ?? "",
              style: GoogleFonts.abel(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
