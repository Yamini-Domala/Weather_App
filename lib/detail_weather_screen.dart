import 'package:flutter/material.dart';
import 'package:weatherapp/weather_model.dart';

class DetailWeatherScreen extends StatelessWidget {
  final Weather weather;

  const DetailWeatherScreen({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('City: ${weather.cityName}', style: const TextStyle(fontSize: 20)),
            Text('Temperature: ${weather.temperature}°C'),
            Text('Condition: ${weather.condition}'),
            Text('Humidity: ${weather.humidity}%'),
            Text('Wind Speed: ${weather.windSpeed} m/s'),
            // Additional details and forecast can be added here
          ],
        ),
      ),
    );
  }
}
