import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forum_mobile_frontend/screens/login_screen.dart';

import 'package:forum_mobile_frontend/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}


void main() {

  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}




class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget firstScreen = LoginScreen();
   getScreen() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    if(token ==null){
      setState(() {
        firstScreen = LoginScreen();
      });
    }
    else{
      setState(() {
        firstScreen= MainScreen();
      });
    }
  }

  @override
  void initState() {
    getScreen();
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: firstScreen,
    );

  }
}

