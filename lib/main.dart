//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:mausam/Activity/loading.dart';
import 'Activity/home.dart';
import 'Activity/location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => Loading(),
        "/home": (context) => Home(),
        "/location": (context) => Location(),
        "/loading": (context) => Loading(),
      },
    );
  }
}
