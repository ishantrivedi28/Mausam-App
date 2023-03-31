import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mausam/Activity/loading.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var city_name = ["Mumbai", "Delhi", "Kolkata", "London"];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    Map info = ModalRoute.of(context)!.settings.arguments as Map;
    String air = info['air_speed_value'];
    String temp = (info['temp_value']);
    if (temp == "NA") {
      print("NA");
    } else {
      air = info['air_speed_value']!.substring(0, 4);
      temp = (info['temp_value']).substring(0, 4);
    }
    String icon = info['icon_value'];
    String getCity = info['city_value'];
    String hum = info['hum_value'];

    String des = info['des_value'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          child: NewGradientAppBar(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blue[200]!],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          preferredSize: Size.fromHeight(0)),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.blue[800]!,
                Colors.blue[300]!,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            )),
            child: Column(children: [
              Container(
                //Search wala container
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                ),
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      if ((searchController.text).replaceAll(" ", "") == "") {
                        print("Blank search");
                      } else {
                        Navigator.pushReplacementNamed(context, "/loading",
                            arguments: {
                              "searchText": searchController.text,
                            });
                      }
                    },
                    child: Container(
                      child: Icon(Icons.search),
                      margin: const EdgeInsets.fromLTRB(2, 0, 5, 0),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search $city",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ]),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      child: Row(children: [
                        Image.network(
                            "http://openweathermap.org/img/wn/$icon@2x.png"),
                        SizedBox(
                          width: 40,
                        ),
                        Column(
                          children: [
                            Text(
                              "$des",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "In $getCity",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      ]),
                      padding: const EdgeInsets.all(26),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 202,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(WeatherIcons.thermometer),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$temp",
                                  style: TextStyle(
                                    fontSize: 90,
                                  ),
                                ),
                                const Text(
                                  "C",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ]),
                      padding: const EdgeInsets.all(26),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              WeatherIcons.humidity,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "$hum",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("percent"),
                      ]),
                      padding: const EdgeInsets.all(26),
                      margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      height: 200,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              WeatherIcons.day_windy,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "$air",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("km/hr"),
                      ]),
                      padding: const EdgeInsets.all(26),
                      margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                      height: 200,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text("Made By Ishan"),
                    Text("Data Provided By Openweather.org"),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
