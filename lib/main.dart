import 'package:flutter/material.dart';
import 'package:weatherapp/screens/loadingscreen.dart';
import 'package:weatherapp/screens/weather_screen.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  // const WeatherApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
