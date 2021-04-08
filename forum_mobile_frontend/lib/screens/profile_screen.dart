

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum_mobile_frontend/models/post.dart';
import 'package:forum_mobile_frontend/models/user.dart';
import 'package:forum_mobile_frontend/screens/login_screen.dart';
import 'package:forum_mobile_frontend/services/post_service.dart';
import 'package:forum_mobile_frontend/services/user_service.dart';
import 'package:forum_mobile_frontend/widgets/CardWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user = User();
  UserService service = UserService();
  List<Post> postss =[];
  List<Widget> cards =[];

  getUser() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int id = int.parse(sharedPreferences.getString('id'));
    User u = await service.getUserById(context, id);
    setState(() {
      user = u;
    });
  }

  Future<List<Post>> getData(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    if(token != null){
      PostService service = PostService();

      List<Post> p13 = await service.getPostByUser(context,user.id);
      setState(() {
        postss = p13;
      });
    }
    else{
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return LoginScreen();
          })
      );
    }
  }

  void getPostCard (context)
  {


    List<Widget> v=[];

    if(postss!=null){

      postss.forEach((post) {
        if(post.post_text != ''){
          CardWidget c = CardWidget(post.id,post.post_owner.name, post.post_owner.picture,
              post.dateSincePosted, post.title, post.post_text, post.comments.length, post.likes);
          v.add(c);
        }

      });
    }


    setState(() {
      cards = v;
    });

  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    getData(context);
    getPostCard(context);
    return SingleChildScrollView(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              color: Color(0xffF6F6FE),
              child: SizedBox(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    Image(
                      image: AssetImage('assets/images/${user.picture}' ?? 'assets/images/default.jpg'),
                      width: 100,
                    ),

                  ],
                ),
              ),
            ),

          ),
          Text(
            ' ${user.name}',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900
            ),
          ),

          Column(
            children: cards,
          )
        ],
      ),
    );
  }
}
