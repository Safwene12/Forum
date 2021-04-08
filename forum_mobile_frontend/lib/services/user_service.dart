import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum_mobile_frontend/http/baseURL.dart';
import 'package:forum_mobile_frontend/models/user.dart';
import 'package:forum_mobile_frontend/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class UserService{
  Future<User> getUserById(context ,int id)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    if(token == null){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return LoginScreen();
          })
      );
    }
    else{
      String url = '${baseUrl}user/$id';

      var res = await http.get(url,headers: {"Authorization": "$token"});

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);
        User user = User.fromJson(body);
        return user;
      }else if(res.statusCode == 401){
        Navigator.push(context,
            MaterialPageRoute(builder: (context){
              return LoginScreen();
            })
        );
      }
      else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load user');

      }

    }
  }

}