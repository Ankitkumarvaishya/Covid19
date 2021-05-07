import 'package:covid19/news.dart';
import 'package:flutter/material.dart';
import 'home.dart';
void main (){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
      'News': (context)=>News(),

      },
      debugShowCheckedModeBanner: false,
      title: "Covid-19",
      home: Home(),
     
    );
  }
}