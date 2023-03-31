import 'package:flutter/material.dart';
import '../Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

String? city = "Kolkata";
String? temp;
String? hum;
String? air_speed;
String? des;
String? mainn;
String? icon;

class _LoadingState extends State<Loading> {
  void startApp(String? city) async {
    Worker instance = Worker(location: "$city");
    await instance.getData();

    temp = instance.temp;
    hum = instance.humidity;
    air_speed = instance.air_speed;
    des = instance.description;
    mainn = instance.main;
    icon = instance.icon;

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value": temp,
        "hum_value": hum,
        "des_value": des,
        "main_value": mainn,
        "icon_value": icon,
        "city_value": city,
        'air_speed_value': air_speed,
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map? search;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      search = ModalRoute.of(context)!.settings.arguments as Map;
      print(search);
    }
    if (search != null) {
      city = search['searchText'];
      print(city);
    }
    startApp(city);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 180,
              ),
              Image.asset(
                "images/mlogo.png",
                height: 240,
                width: 240,
              ),
              const Text(
                "Mausam App",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Made by Ishan",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SpinKitWave(
                color: Colors.white,
                size: 50.0,
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue[300],
    );
  }
}
