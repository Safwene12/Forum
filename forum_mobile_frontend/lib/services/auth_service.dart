import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum_mobile_frontend/http/baseURL.dart';
import 'package:forum_mobile_frontend/models/user.dart';
import 'package:forum_mobile_frontend/screens/login_screen.dart';
import 'package:forum_mobile_frontend/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

signIn(String username , String pass , context) async{
  String url ="${baseUrl}auth/signin";
  Map body = {"username" : username , "password" : pass};
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  var jsonResponse ;
  var res = await http.post(url, body:jsonEncode(body) , headers: {
    "Content-Type":"application/json",
    'Accept': 'application/json',});
  var data = jsonDecode(res.body);


  if(res.statusCode == 200 ){
    print(res.statusCode);
    jsonResponse = json.decode(res.body);

    if(jsonResponse != null){
      sharedPreferences.setString("token", "${data['tokenType']} ${data['accessToken']}");
      sharedPreferences.setString('id', '${data['id']}');
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return MainScreen();
          })
      );
    }
  }
  else if(res.statusCode == 401){
    print(res.statusCode);
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Wrong username or password'),
                Text('Please try again or contact our assistant service'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  else {
    print('Server lost');
    /**setState(() {
      isLoading = false;
    });**/
    //print('Response status : ${res.statusCode}');
  }

}



register(User user , context) async{
  String url ="${baseUrl}auth/signup";
  Map body = {
    "username" : user.username,
    "password": user.password,
    "name" : user.name,
    "email" : user.email ,
    "dateofbirth" :user.dateofbirth,
    "phone" : user.phone
  };
    var res = await http.post(url, body:jsonEncode(body) , headers: {
      "Content-Type":"application/json",
      'Accept': 'application/json'});

    if(res.statusCode==200){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return LoginScreen();
          })
      );
    }







}
