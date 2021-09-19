import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'weather_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();

    getCurrentLocation();
  }

  void getCurrentLocation() async {
    var weatherData = await WeatherModel().getWeatherData();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => WeatherScreen(weatherInfo: weatherData)));
    // print(weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF34495e),
      // appBar: AppBar(
      //   title: Text("Decode App"),
      //   centerTitle: true,
      // ),
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
