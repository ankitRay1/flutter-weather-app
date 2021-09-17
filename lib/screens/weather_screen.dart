import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/constant.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/services/location.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.weatherInfo});
  var weatherInfo;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherModel weatherModel = new WeatherModel();
  final TextEditingController _textEditingController = TextEditingController();
  int tempeature;
  String cityName;
  var dateTime;
  var date;
  var time;
  int humidity;
  int pressure;
  var weatherIcon;
  double windSpeed;
  String weather;
  int currenTime;
  var backgroundImage;

  @override
  void initState() {
    super.initState();

    showWeatherData(widget.weatherInfo);
  }

  void showWeatherData(dynamic weatherInfo) {
    setState(() {
      int condtionNumber = weatherInfo['weather'][0]['id'];
      weather = weatherInfo['weather'][0]['main'];

      tempeature = weatherInfo['main']['temp'].toInt();
      humidity = weatherInfo['main']['humidity'].toInt();
      pressure = weatherInfo['main']['pressure'];
      cityName = weatherInfo['name'];
      windSpeed = weatherInfo['wind']['speed'] * 18 / 5;
      weatherIcon =
          'https://openweathermap.org/img/wn/${weatherInfo['weather'][0]['icon']}@2x.png';

      print(weatherIcon);

      backgroundImage = weatherModel.getWeatherImage(condtionNumber);

      dateTime = DateTime.fromMillisecondsSinceEpoch(weatherInfo['dt'] * 1000,
          isUtc: false);

      date = DateFormat.yMMMEd().format(dateTime);
      time = DateFormat('hh:mm a').format(dateTime);
      currenTime = int.parse(DateFormat.H().format(dateTime));

      print(date);
      print(time);

      print(dateTime);
    });
    // print(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: Text(""),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              backgroundImage,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black38),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 90),
                            TextField(
                              controller: _textEditingController,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                              autofocus: false,
                              readOnly: false,
                              cursorColor: Colors.black,
                              decoration: KInputDecoration,
                              onTap: () async {
                                Prediction prediction =
                                    await PlacesAutocomplete.show(
                                        context: context,
                                        apiKey: kGoogleApiKey,
                                        mode: Mode.overlay, // Mode.fullscreen
                                        language: "en",
                                        strictbounds: false,
                                        types: [],
                                        components: [
                                      Component(Component.country, "IN")
                                    ]);
                                if (prediction != null) {
                                  _textEditingController.text =
                                      prediction.description;
                                  final places =
                                      GoogleMapsPlaces(apiKey: kGoogleApiKey);
                                  var detailsByPlaceId = await places
                                      .searchByText(prediction.description);
                                  final lat = detailsByPlaceId
                                      .results.first.geometry.location.lat;
                                  final lang = detailsByPlaceId
                                      .results.first.geometry.location.lng;
                                  print('$lat \n $lang');

                                  Future<dynamic> updateWeather() async {
                                    // UserLocation(
                                    //     latitude: lat, longitude: lang);

                                    var weather = await weatherModel
                                        .getUpdatedWeatherData(lat, lang);
                                    showWeatherData(weather);
                                  }

                                  setState(() {
                                    updateWeather();
                                  });
                                }
                              },
                            ),
                            SizedBox(height: 80),
                            Text(cityName ?? '',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10.0),
                            Text('$time  -  $date',
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                )),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${tempeature ?? ''}\u2103',
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 85.0,
                                )),
                            SizedBox(height: 10.0),
                            Row(
                              children: [
                                Image.network(
                                  weatherIcon,
                                  width: 65,
                                  height: 65,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10.0),
                                Text(weather,
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 27.0,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 40),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white30)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Wind",
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  windSpeed.toStringAsFixed(2),
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "km/h",
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      color: Colors.white38,
                                      height: 5,
                                      width: 50,
                                    ),
                                    Container(
                                      color: Colors.greenAccent,
                                      height: 5,
                                      width: 10,
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Pressure",
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  pressure.toString(),
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "%",
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      color: Colors.white38,
                                      height: 5,
                                      width: 50,
                                    ),
                                    Container(
                                      color: Colors.redAccent,
                                      height: 5,
                                      width: 5,
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Humidity",
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  humidity.toString(),
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "%",
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      color: Colors.white38,
                                      height: 5,
                                      width: 50,
                                    ),
                                    Container(
                                      color: Colors.red,
                                      height: 5,
                                      width: 10,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
