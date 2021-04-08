import 'package:flutter/material.dart';
import 'package:forum_mobile_frontend/contants/constants.dart';
import 'package:forum_mobile_frontend/screens/main_screen.dart';

AppBar Appbar(String text , context) {
  return AppBar(
    leading: new IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return MainScreen();
          })
      );
    }),
    title: Text(
      text,

      style: TextStyle(
        color: kAppBarColor,
        fontFamily: "Roboto-Regular",
      ),
    ),
    backgroundColor: kAppBarTextColor,
  );
}