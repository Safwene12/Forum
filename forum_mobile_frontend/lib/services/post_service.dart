
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum_mobile_frontend/http/baseURL.dart';
import 'package:forum_mobile_frontend/models/post.dart';
import 'package:forum_mobile_frontend/screens/home_screen.dart';
import 'package:forum_mobile_frontend/screens/login_screen.dart';
import 'package:forum_mobile_frontend/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class PostService{
  Future<List<Post>> getAllPosts(context) async{
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
      String url = '${baseUrl}post/all';

      var res = await http.get(url,headers: {"Authorization": "$token"});

      if (res.statusCode == 200) {

        List<dynamic> body = jsonDecode(res.body);
        List<Post> posts = body
            .map(
              (dynamic item) => Post.fromJson(item),
        )
            .toList();
        return posts;
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
        throw Exception('Failed to load posts');

      }

    }
    }

    Future<Post> getPostById(context ,int id) async
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
        String url = '${baseUrl}post/get/$id';

        var res = await http.get(url,headers: {"Authorization": "$token"});

        if (res.statusCode == 200) {
          dynamic body = jsonDecode(res.body);
          Post post = Post.fromJson(body);
          return post;
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
          throw Exception('Failed to load posts');

        }

      }
    }


  addPost(Post post , context ) async{
    String url ="${baseUrl}post/create";
    Map body = {"title" : post.title , "post_text" : post.post_text};
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

}