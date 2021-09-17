import 'package:flutter/material.dart';

String cloudy = "assets/cloudy.jpeg";
String rainy = "assets/rainy.jpg";

String sunny = "assets/sunny.jpg";
const kGoogleApiKey = "AIzaSyBdCSyvsDoxtmHuuj5LhZnjLo02psYWKQI";

String night = "assets/night.jpg";
String snowfall = "assets/snowfall.jpg";
String dizzle = "assets/dizzle.jpg";

const KInputDecoration = InputDecoration(
  prefixIcon: Icon(Icons.search, color: Colors.black),
  filled: true,
  hintText: "Enter the City",
  fillColor: Colors.white,
  counter: Offstage(),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide.none),
);

//  actions: [
//           GestureDetector(
//             onTap: () => print("menu button press!"),
//             child: Container(
//               margin: EdgeInsets.only(right: 20.0),
//               child: TextButton(
//                 onPressed: () async {
//                   var weather = await weatherModel.getWeatherData();
//                   showWeatherData(weather);
//                 },
//                 child: Icon(
//                   Icons.near_me,
//                   color: Colors.white,
//                   size: 50,
//                 ),
//               ),
//             ),
//           )
//         ],