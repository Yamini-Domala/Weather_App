import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'weather_model.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=8e23e84105a431e251e54afb74d9a0a6&units=metric'));

    if (response.statusCode == 200) {
      _weather = Weather.fromJson(jsonDecode(response.body));
    } else {
      _weather = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
