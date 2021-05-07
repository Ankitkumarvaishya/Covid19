import 'package:covid19/myth.dart';
import 'package:covid19/shome.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'Worldupdates.dart';
import 'news.dart';
import 'dart:convert';

class Faq extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  //for navigating to a certain website url luncher
  Future<void> _donate(String url) async {
    if (await canLaunch(url) != null) {
      launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //for the circularprogressindicator
  bool loading = true;
  //for storing the jsondata
  var data;
  String url = "https://corona.askbhunte.com/api/v1/faqs";
  Future getLatestUpdate() async {
    //getting the api into the variable response
    var response =
        await http.get(Uri.parse(url), headers: {'Accept': 'application/json'});
    //decoding the response and storing in jsonData
    var jsonData = json.decode(response.body);
    //storing the decoded data of jsonData
    setState(() {
      data = jsonData['data'];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        title: Text("Covid FAQ"),
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
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    while(data[index]['question_np'] != null) {
                                           
                      return Card(
                        elevation: 50.0,
                        child: Column(
                          children: [
                           
                            ListTile(
                              title: Text(
                                data[index]['question_np'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index]['answer_np'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                      );
                      
                    }
                    
                  },
                ),
              ),
            ),
    );
  }
}
