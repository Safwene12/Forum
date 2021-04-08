import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum_mobile_frontend/http/baseURL.dart';
import 'package:forum_mobile_frontend/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class LikeService{
  Future<bool> isLiked(context ,int idUser , idPost) async
  {
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

      String url = '${baseUrl}like/post/isLiked/${idUser}/${idPost}';

      var res = await http.get(url,headers: {"Authorization": "$token"});

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);
        bool isLiked = body;
        return isLiked;
      }else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load likes');

      }

    }
  }

  Future<void> like(context ,int idUser , idPost) async
  {
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

      String url = '${baseUrl}like/post/${idUser}/${idPost}';

      var res = await http.post(url,headers: {"Authorization": "$token"});



    }
  }
}