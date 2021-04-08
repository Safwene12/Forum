import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum_mobile_frontend/http/baseURL.dart';
import 'package:forum_mobile_frontend/models/comment.dart';
import 'package:forum_mobile_frontend/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class CommentService{
    createComment(Comment comment , context) async{
      String url ="${baseUrl}comment/create";
      Map body = {"comment_text" : comment.comment_text , "belong_post" : {"id": comment.belong_post.id}};
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
        var jsonResponse ;
        var res = await http.post(url, body:jsonEncode(body) , headers: {
          "Content-Type":"application/json",
          'Accept': 'application/json',
          "Authorization": "$token"});


      }
    }

    deleteComment(int id , context) async{
      String url ="${baseUrl}comment/delete/${id}";
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
        var jsonResponse ;
        var res = await http.delete(url, headers: {
          "Content-Type":"application/json",
          'Accept': 'application/json',
          "Authorization": "$token"});
          print(res.statusCode);

      }
    }
}