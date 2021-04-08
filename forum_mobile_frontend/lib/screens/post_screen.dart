import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum_mobile_frontend/models/post.dart';
import 'package:forum_mobile_frontend/models/user.dart';
import 'package:forum_mobile_frontend/services/post_service.dart';
import 'package:forum_mobile_frontend/widgets/CardWidget.dart';

import 'package:forum_mobile_frontend/widgets/add_button_widget.dart';
import 'package:forum_mobile_frontend/widgets/app_bar.dart';
import 'package:forum_mobile_frontend/widgets/post_widget.dart';
import 'package:forum_mobile_frontend/widgets/reaction_button.dart';
import 'package:google_fonts/google_fonts.dart';


Post p=Post();
String title='Text title is here';
String pic ='default.jpg';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
  int id;
  PostScreen({this.id});
}


PostService postService = PostService();
User u = User(name: 'Safouane');
class _PostScreenState extends State<PostScreen> {

  Post  post = Post(post_owner: u,title: 'title',post_text: 'post_text', dateSincePosted: 'date');
  bool isLoading=false;

  @override
  void initState() {
    super.initState();
    this.fetchPost();
  }
  fetchPost() async{
    PostService postService = PostService();
    Post p = await postService.getPostById(context, widget.id);
    if(p != null){
      setState(() {
        post =p;
        pic = post.post_owner.picture;
      });
    }else{
      setState(() {
        User u = User(name: 'Safouane');
        post = Post(post_owner: u,title: 'title',post_text: 'post_text',id: 5);
      });
    }

  }

  @override
  Widget build(BuildContext context) {

   // print(post.id);
    return SafeArea(
        child: Scaffold(

          backgroundColor: Color(0xFFC9CCD1),
          appBar: Appbar(  post.title, context),
          body:SingleChildScrollView(
            child: Stack(
                children: [Column(
                    children: [
                      Padding(

                        padding: EdgeInsets.only(top: 5),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,

                            ),

                            child: Column(children :[
                              PostWidget(
                                id: widget.id,
                                date: post.dateSincePosted,
                                username: post.post_owner.name ,
                                likes: post.likes,
                                likeNum: 20,
                                picture: pic ,
                                text: post.post_text,
                                comments: post.comments,

                              )


                            ]

                            )
                        ),
                      ),


                    ]
                ),
                ]
            ),
          ),


        )



    );




  }






}
