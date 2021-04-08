

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum_mobile_frontend/contants/constants.dart';
import 'package:forum_mobile_frontend/models/post.dart';
import 'package:forum_mobile_frontend/models/user.dart';
import 'package:forum_mobile_frontend/screens/main_screen.dart';
import 'package:forum_mobile_frontend/services/post_service.dart';
import 'package:forum_mobile_frontend/services/user_service.dart';
import 'package:forum_mobile_frontend/widgets/app_bar.dart';
import 'package:forum_mobile_frontend/widgets/login_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  User user = User();
  String pic = 'default.jpg';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController postController = TextEditingController();

  void validateAndSave() async{
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      PostService service = PostService();
      Post post = Post();
      post.title = titleController.text;
      post.post_text=postController.text;
      await service.addPost(post, context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return MainScreen();
          })
      );

    } else {
      print('Form is invalid');
    }
  }


  @override
  void initState() {
    super.initState();
    this.getUser();

  }
  Future<User> getUser() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int id = int.parse(sharedPreferences.getString('id'));

    UserService service = UserService();
    service.getUserById(context, id).then((value) {
      setState(() {
        user = value;
        pic=user.picture;
      });
      return user;
    });
  }
  Post getPost(){
    Post p =Post(title: titleController.text,likes: 0,comments: null,dateSincePosted: 'posted few seconds ago', post_text:
    postController.text,post_owner: new User(username: user.name),dateofpublication: 'posted few seconds ago');
    return p;
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: Appbar('Create Post',context),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Card(
                    child: SizedBox(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Image(
                              image: AssetImage('assets/images/${pic}'),
                              width: 100,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Ask a question , or share your interests',
                      style: GoogleFonts.openSans(

                        color: Colors.black54,
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                      )
                  ),
                ),

                      Container(
                        height: 75,
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.bottom,
                          controller: titleController ,
                          validator: (value) =>
                          value.isEmpty ? 'Title cannot be blank' : null,
                          style: TextStyle(
                            color: Colors.black,

                          ),

                          decoration: kTitleField,
                          onChanged: (value){

                          },
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                           // width: 200.0,
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),

                            child: TextFormField(
                              validator: (value) =>
                              value.isEmpty ? 'Post cannot be blank' : null,
                              controller: postController,
                              maxLines: 5,
                                style: TextStyle(
                                    //fontSize: 30.0,
                                    height: 2.0,
                                    color: Colors.black
                                ),
                              decoration: kPostField,
                            )
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.all(15),
                          child: LoginButton(text: 'Post' , validateAndSave: validateAndSave),
                      ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
