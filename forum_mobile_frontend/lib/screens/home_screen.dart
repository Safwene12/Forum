import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:forum_mobile_frontend/contants/constants.dart';
import 'package:forum_mobile_frontend/models/post.dart';
import 'package:forum_mobile_frontend/screens/login_screen.dart';
import 'package:forum_mobile_frontend/screens/new_post.dart';
import 'package:forum_mobile_frontend/services/auth_service.dart';
import 'package:forum_mobile_frontend/services/post_service.dart';
import 'package:forum_mobile_frontend/widgets/CardWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

const postUser ='Safouane Jelassi';
const title = 'Card Title';
const text = 'Here we will see a little bit of the post text Here we will see a little bit of the post text '
    'Here we will see a little bit of the post textHere we will see a little bit of the post text ...';
const date = '2 hours ago';
const likeNumber = 2;
List<Post> posts =[];
List<Widget> cards =[];
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
Post p = Post();
List<Post> postss =[];

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Post>> getData(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    if(token != null){
      PostService service = PostService();

      List<Post> p13 = await service.getAllPosts(context);
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

  List<Widget> children(){
    if(cards.length==0){
      List<Widget> c =[];
      Container ce = Container(
        margin: EdgeInsets.all(40),
        child: Text('No post is available , please be our first'),
      );
      c.add(ce);

      return c;
    }
    else{

      return cards;
    }
  }

  @override
  void initState() {
    getData(context);

    super.initState();
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
  Widget build(BuildContext context) {
    //getData(context);
    getPostCard(context);
    List<Post> matchs =[];
    List<Post> workingList = postss;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(

                     'Feel free to join any post ',
                     style: GoogleFonts.lato(

                       color: kAppBarTextColor,
                       textStyle: Theme.of(context).textTheme.headline4,
                       fontSize: 30,
                       fontWeight: FontWeight.w700,
                       fontStyle: FontStyle.italic,
                   ),

                ),
          ),

          Container(

            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(

              style: TextStyle(
                color: Colors.black,
              ),

              decoration: kTextFieldInputDecoration,
              onChanged: (value){
                print(value);
                workingList.forEach((post) {
                  if(post.title.contains(value)){
                    matchs.add(post);
                  }
                });
                setState(() {
                  postss = matchs;
                });
                if(value.isEmpty){
                  setState(() {
                    postss=workingList;
                  });
                }

              },
            ),
          ),

           Column(
              children: cards
            ),



        ],
      ),
    );

  }


}


