import 'package:forum_mobile_frontend/models/post.dart';
import 'package:forum_mobile_frontend/models/user.dart';

class Comment{
  int id;
  String comment_text;
  String dateofpublication;
  String attachement;
  User comment_owner;
  Post belong_post;
  String dateSinceCommented;

  Comment({this.id,this.dateofpublication,this.attachement,this.comment_owner,this.comment_text,this.belong_post,this.dateSinceCommented});
  factory Comment.fromJson(Map<String, dynamic> json){
    return Comment(
      id : json['id'],
      comment_text : json['comment_text'],
      dateofpublication : json['dateofpublication'],
      attachement : json['attachement'],
      comment_owner : User.fromJson(json['comment_owner']),
        dateSinceCommented : json['dateSinceCommented'],

    );
  }
}