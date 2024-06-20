import 'package:flutter/material.dart';
import 'package:weatherapp/stmanageprovider.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/main_weather_screen.dart';
import 'package:weatherapp/user_profile_screen.dart';
import 'package:weatherapp/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/main': (context) => const MainWeatherScreen(),
          '/profile': (context) => const UserProfileScreen(),
        },
      ),
    );
  }
}
