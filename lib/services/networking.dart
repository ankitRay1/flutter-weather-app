import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'location.dart';
import 'dart:convert';

class Networking {
  Networking({this.apiUrl});

  String apiUrl;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      String result = response.body;

      // int ConditionId = jsonDecode(result)['weather'][0]['id'];

      // double temperature = jsonDecode(result)['main']['temp'];
      // String cityName = jsonDecode(result)['name'];
      // print(
      //     'The Weather Data is : \n $ConditionId \n $temperature \n $cityName');

      return jsonDecode(result);
    } else {
      print(response.statusCode);
    }
  }
}
