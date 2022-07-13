import 'package:flutter/material.dart';
import 'package:tic/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:const Color(0xFF00061a) ,
        primarySwatch: Colors.blue,
        shadowColor:const Color(0xFF001456),
        brightness: Brightness.dark,
        splashColor:const Color(0xFF4169e8) ,
      ),
      home:  HomeScreen(),
    );
  }
}