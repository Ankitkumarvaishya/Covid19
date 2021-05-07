import 'package:covid19/myth.dart';
import 'package:covid19/news.dart';
import 'package:covid19/shome.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import 'faq.dart';

class World extends StatefulWidget {
  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> {
  //for the circularprogressindicator
  bool loading = true;
  //for storing the jsondata
  var data;
  String url = "https://data.askbhunte.com/api/v1/world";
  Future getLatestUpdate() async {
    //getting the api into the variable response
    var response = await http.get(Uri.parse(url));
    //decoding the response and storing in jsonData
    var jsonData = json.decode(response.body);
    //storing the decoded data of jsonData
    setState(() {
      data = jsonData;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getLatestUpdate();
  }

  //For adding the refresh indicator
  Future<Null> refresh() async {
    await Future.delayed(Duration(seconds: 3));
    getLatestUpdate();
  }
//for the donation
 Future<void> _donate(String url) async {
    if (await canLaunch(url) != null) {
       launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        title: Text("Covid-19 Updates of World"),
      ),
      drawer: Drawer(
              child: Container(
          color: Color.fromRGBO(50, 75, 205, 1),
          child: ListView(
              children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top:15.0)),
                    Text('Corona Virus - 19' , style: TextStyle(color:Colors.white , fontSize: 30.0 , fontWeight: FontWeight.bold),),
                    SizedBox(height: 10.0),
                    Text('#Stayhome', style: TextStyle(color:Colors.white , fontSize: 25.0),),
                    SizedBox(height: 10.0),
                    Text('#Staysafe' , style: TextStyle(color:Colors.white , fontSize: 20.0),),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(50, 75, 205, 1),
                ),
              ),
                ListTile(
                leading: Icon(
                  Icons.home,
                  size: 30,
                  color: Colors.white,
                ),
                title: Text(
                  "News",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => News()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.update,
                  size: 30,
                  color: Colors.white,
                ),
                title: Text(
                  "Nepal's Updates",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Shome()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.update,
                  size: 30,
                  color: Colors.white,
                ),
                title: Text(
                  "World's Updates",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => World()));
                },
              ),
                ListTile(
                leading: Icon(
                  Icons.dangerous,
                  size: 30,
                  color: Colors.white,
                ),
                title: Text(
                  "Myths",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Myth()));
                },
              ),
               ListTile(
                leading: Icon(
                  Icons.question_answer,
                  size: 30,
                  color: Colors.white,
                ),
                title: Text(
                  "FAQ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Faq()));
                },
              ),
               ListTile(
                leading: Icon(
                  Icons.money,
                  size: 30,
                  color: Colors.white,
                ),
                title: Text(
                  "Donate",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                onTap: () {
                 _donate("https://covid19responsefund.org");
                },
              ),
           
              
            ],
          ),
        ),
      ),
      
      //here using the ternery operator
      body: loading == true
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: refresh,
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.red,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        leading: FlutterLogo(),
                        title: Text("Total Cases"),
                        subtitle: Text(data['cases'].toString()),
                      ),
                    ),
                     SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.amber,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        leading: FlutterLogo(),
                        title: Text("Total Deaths"),
                        subtitle: Text(data['deaths'].toString()),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blue,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        leading: FlutterLogo(),
                        title: Text("Today's Cases"),
                        subtitle: Text(data['todayCases'].toString()),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.orange,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        leading: FlutterLogo(),
                        title: Text("Today's Death"),
                        subtitle: Text(data['todayDeaths'].toString()),
                      ),
                    ),
                   
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.orange,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        leading: FlutterLogo(),
                        title: Text("Today's Recovered"),
                        subtitle: Text(data['todayRecovered'].toString()),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blue,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        leading: FlutterLogo(),
                        title: Text("Critical Cases"),
                        subtitle: Text(data['critical'].toString()),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      //
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.red,
                      ),
                      child: ListTile(
                        leading: FlutterLogo(),
                        title: Text("Affected Countries"),
                        subtitle: Text(data['affectedCountries'].toString()),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Wrap(
                        children: [
                          Text(
                            "Source: MOHP",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                     ],
                ),
              ),
            ),
    );
  }
}
