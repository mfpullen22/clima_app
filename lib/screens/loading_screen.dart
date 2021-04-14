import 'package:flutter/material.dart';
import "package:clima/services/location.dart";
import "package:http/http.dart" as http;
import "dart:convert";

const apiKey = "cef7d12b9ccedfccfe618ef9d0d39637";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=$apiKey"));
    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);

      var temperature = decodedData["main"]["temp"];
      print(temperature);

      var conditionNum = decodedData["weather"][0]["id"];
      print(conditionNum);

      var cityName = decodedData["name"];
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}

//Just a comment
//Another comment
