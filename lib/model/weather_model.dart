import 'package:weatherapp/constant.dart';
import 'package:weatherapp/services/location.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/services/networking.dart';

const apiKey = '90dd931581b16cea2ae2a89a027dd12b';

class WeatherModel {
  Future<dynamic> getUpdatedWeatherData(
      double latitude, double longitude) async {
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    print(apiUrl);

    Networking networking = new Networking(apiUrl: apiUrl);
    return networking.getData();
  }

  Future<dynamic> getWeatherData() async {
    UserLocation location = UserLocation();

    await location.getlocation();
    await location.determinePosition();

    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';

    // print(apiUrl);

    Networking networking = new Networking(apiUrl: apiUrl);
    return networking.getData();
  }

  String getWeatherImage(int condition) {
    if (condition < 300) {
      return cloudy;
    } else if (condition >= 300 && condition <= 321) {
      return dizzle;
    } else if (condition > 321 && condition <= 531) {
      return rainy;
    } else if (condition > 531 && condition <= 622) {
      return snowfall;
    } else if (condition > 622 && condition <= 781) {
      return sunny;
    } else if (condition > 781 && condition <= 800) {
      return sunny;
    } else {
      return cloudy;
    }
  }
}

    // int sunRiseTime = 6;
  // int sunSetTime = 18;
  // int currenTime;
  // String dayCheck;
  // String dayAndNight;

 // if (currenTime > sunRiseTime && currenTime < 12) {
    //   dayCheck = "Morning";
    // } else if (currenTime > sunRiseTime &&
    //     currenTime > 12 &&
    //     currenTime < sunSetTime) {
    //   dayCheck = "AfterNoon";
    // } else if (currenTime > sunRiseTime &&
    //     currenTime > 12 &&
    //     currenTime > sunRiseTime) {
    //   dayCheck = "Night";
    // } else {
    //   dayCheck = "MidNight";
    // }