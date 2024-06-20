import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/weather_model.dart';
import 'package:weatherapp/stmanageprovider.dart';
import 'package:weatherapp/detail_weather_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainWeatherScreen extends StatefulWidget {
  const MainWeatherScreen({super.key});

  @override
  _MainWeatherScreenState createState() => _MainWeatherScreenState();
}

class _MainWeatherScreenState extends State<MainWeatherScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _homeLocation;
  bool _isHomeWeatherLoading = true;
  Weather? _homeWeather;

  @override
  void initState() {
    super.initState();
    _loadHomeLocation();
  }

  Future<void> _loadHomeLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? location = prefs.getString('location');
    if (location != null && location.isNotEmpty) {
      _homeLocation = location;
      await _fetchHomeWeather(location);
    } else {
      setState(() {
        _isHomeWeatherLoading = false;
      });
    }
  }

  Future<void> _fetchHomeWeather(String location) async {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    await weatherProvider.fetchWeather(location);
    setState(() {
      _homeWeather = weatherProvider.weather;
      _isHomeWeatherLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
         title:  const Text('Weather App',
         style: TextStyle(color: Color.fromARGB(255, 205, 7, 255),
         
         ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_homeLocation != null) ...[
              const Text(
                'Home Location Weather:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Color.fromARGB(255, 158, 101, 255)),
              ),
              _isHomeWeatherLoading
                  ? const CircularProgressIndicator()
                  : _homeWeather != null
                      ? ListTile(
                          title: Text('City: ${_homeWeather!.cityName}'),
                          subtitle: Text(
                              'Temperature: ${_homeWeather!.temperature.toString()}°C'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailWeatherScreen(
                                    weather: _homeWeather!),
                              ),
                            );
                          },
                        )
                      : const Text('Failed to load weather for home location.'),
              const SizedBox(height: 20),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search City',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      weatherProvider.fetchWeather(_searchController.text);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            weatherProvider.isLoading
                ? const CircularProgressIndicator()
                : weatherProvider.weather != null
                    ? Expanded(
                        child: ListView(
                          children: [
                            ListTile(
                              title: Text(
                                  'City: ${weatherProvider.weather!.cityName}'),
                              subtitle: Text(
                                  'Temperature: ${weatherProvider.weather!.temperature.toString()}°C'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailWeatherScreen(
                                        weather:
                                            weatherProvider.weather!),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    : const Text('Enter a city name to get weather information'),
          ],
        ),
      ),
    );
  }
}
