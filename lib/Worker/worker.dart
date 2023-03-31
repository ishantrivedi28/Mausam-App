import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Worker {
  String? location;
  String? temp;
  String? humidity;
  String? air_speed;
  String? description;
  String? main;
  String? icon;

  Worker({this.location});

  Future<void> getData() async {
    try {
      String? appId = dotenv.env['APP_ID'];
      Response response = await get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$appId'));
      Map data = jsonDecode(response.body);

      Map temp_data = data['main'];
      String getHumidity = temp_data['humidity'].toString();
      double getTemp = temp_data['temp'] - 273.15;

      Map wind = data['wind'];
      double getAir_speed = wind['speed'] / 0.27777777777778;

      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getMain_des = weather_main_data['main'];
      String getDesc = weather_main_data['description'];
      icon = weather_main_data["icon"];

      temp = getTemp.toString();
      humidity = getHumidity;
      air_speed = getAir_speed.toString();
      description = getDesc;
      main = getMain_des;
      icon = weather_main_data["icon"];
    } catch (e) {
      temp = "NA";
      humidity = "NA";
      air_speed = "NA";
      description = "No data";
      main = "NA";
      icon = "09d";
    }
  }
}
