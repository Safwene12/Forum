import 'dart:core';

import 'package:forum_mobile_frontend/models/comment.dart';
import 'package:forum_mobile_frontend/models/user.dart';


class Post{
  int id;
  String title;
  String post_text;

  String dateofpublication;
  String attachement;
  User post_owner;
  List<Comment> comments;
  String dateSincePosted;
  int likes;
  Post({this.id,this.title,this.post_text,this.dateofpublication,this.attachement,this.post_owner,this.comments,
  this.likes,this.dateSincePosted});
  factory Post.fromJson(Map<String, dynamic> json){
    var list = json['comments'] as List;
    List<Comment> commentsList = list.map((e) => Comment.fromJson(e)).toList();

    return Post(
      id : json['id'],
      title : json['title'],
      post_text : json['post_text'],
      dateofpublication : json['dateofpublication'],
      attachement : json['attachement'],
      post_owner : User.fromJson(json['post_owner']),
      comments: commentsList,
      dateSincePosted: json['dateSincePosted'],
      likes: json['likes'],
    );
  }
}