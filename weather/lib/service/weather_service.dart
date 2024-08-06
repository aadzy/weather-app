import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService{

  static const url = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
        Uri.parse('$url?q=$cityName&appid=$apiKey&units=metric'));
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    }
    else {
      throw Exception('Failed to load weather data');
    }
  }

    Future<String> getCurrentCity() async {
      try {
        //get permission
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }
        //fetch location
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high
        );

        //convert to placemark

        List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

        //extract city name
        String? city = placemarks[0].locality;

        return city ?? "";
      }
      catch(e) {
        print('error getting current city $e');

        return '';
      }
    }


}