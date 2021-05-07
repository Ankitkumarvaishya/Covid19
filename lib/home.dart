import 'package:flutter/material.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void startTimer() {
    Timer(
      Duration(seconds: 5),
      () {
        //move to the home1 route
        Navigator.of(context).pushReplacementNamed('News');
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(children: [
                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1)),
                  Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/splash.jpg"),
                      radius: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Wear a mask.Save lives.",
                      style: TextStyle(color: Colors.white, fontSize: 30.0 , fontWeight: FontWeight.bold ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Wear a mask",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                   Center(
                    child: Text(
                      "Clean your hands",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                   Center(
                    child: Text(
                      "Keep a safe distance",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
