import 'package:flutter/material.dart';
import 'package:forum_mobile_frontend/contants/constants.dart';
import 'package:forum_mobile_frontend/models/comment.dart';
import 'package:forum_mobile_frontend/models/post.dart';
import 'package:forum_mobile_frontend/screens/post_screen.dart';
import 'package:forum_mobile_frontend/services/comment_service.dart';
import 'package:forum_mobile_frontend/services/like_service.dart';
import 'package:forum_mobile_frontend/services/post_service.dart';
import 'package:forum_mobile_frontend/widgets/CardWidget.dart';
import 'package:forum_mobile_frontend/widgets/comment_widget.dart';
import 'package:forum_mobile_frontend/widgets/reaction_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PostWidget extends StatefulWidget {
  @override
  _PostWidgetState createState() => _PostWidgetState();
   int id =0;
   String picture ='' ;
   String username='' ;
   String date=''  ;
   String text=''  ;
   int likeNum=0 ;
   int likes=0;

   List<Comment> comments;
   Function onTap ;
  PostWidget({this.id,this.picture , this.username , this.date , this.text , this.likeNum , this.comments,this.likes ,this.onTap});
}

class _PostWidgetState extends State<PostWidget> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Widget> getCommentsCard (){



    List<CommentWidget> commentsCard =[];


      if(widget.comments != null){
        widget.comments.forEach((com) {

          CommentWidget c = CommentWidget(
            id: com.id,
              text: '${com.comment_text}',
              username: '${com.comment_owner.name}',
              date: '${com.dateSinceCommented}',
              image: '${com.comment_owner.picture}'
          );
          commentsCard.add(c);



        });
      }

    return commentsCard;

  }
  FocusNode myFocusNode;
  bool isLiked = false;


  void commentButton(){
    myFocusNode.requestFocus();
  }
  void likeCon() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int idUser = int.parse(sharedPreferences.getString('id'));
    LikeService service = LikeService();
    await service.like(context, idUser, widget.id);
  }

  void like(){
    likeCon();

    setState(() {

      this.isLiked = !this.isLiked;
      if(this.isLiked==true){
        widget.likes++;
      }
      else{
        widget.likes--;
      }
      print(this.isLiked);
    });
  }
  void isLikedFunc() async{
    LikeService service = LikeService();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int idUser = int.parse(sharedPreferences.getString('id'));

    bool b = await service.isLiked(context, idUser, widget.id);

    setState(() {
      isLiked = b;
    });

  }

  int commentNumber(){
    if(widget.comments==null){
      return 0;
    }
    return widget.comments.length;

  }
  Widget likeButton(){
    if(isLiked){
      return LikeButton(text :' Like' , icon :Icons.favorite,setstat: like) ;
    }
    else{
      return  ReactionsButton(text :' Like' , icon :Icons.favorite_border,setstat: like) ;

  }

  }

  void comment() async{
    if(emailController.text !=''){
      Post p = Post(id: widget.id);
      Comment c = Comment(comment_text: emailController.text,belong_post: p);
      CommentService service = CommentService();
      await service.createComment(c, context);
      PostService postService = PostService();
      Post p1 = await postService.getPostById(context, widget.id);
      setState(() {
        widget.comments=p1.comments;
      });
      emailController.clear();
      myFocusNode.unfocus();

    }

  }



  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    isLikedFunc();
    //print(isLiked);


  }


  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Card(

      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/${widget.picture}'),
            ),
            title: Text(
              widget.username ?? 'Username',
              style: TextStyle(
                  color: kPostTextColor,
                  fontFamily: 'SourceSansPro',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),
            ),
            subtitle: Text(
              widget.date,
              style: TextStyle(
                  color : kTextSecondaryColor
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Text(
                    widget.text,
                    style: GoogleFonts.roboto(

                      color: kPostTextColor,

                      fontSize: 20,
                      //fontWeight: FontWeight.w700,
                      //fontStyle: FontStyle.italic,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child:Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                            ' ${widget.likes} '
                        ),
                        Icon(

                          Icons.favorite,
                          color: Color(0xFFE61B43),
                        ),

                        Text(
                            ' ${commentNumber()} '
                        ),
                        Icon(
                          Icons.comment,
                          color: Color(0xFF0083FF),
                        ),
                      ],
                    ),

                  ),
                  Container(
                    margin : EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                            //width: 16.0,
                              color: Color(0xFFC9CCD1)
                          ),
                          bottom: BorderSide(
                              color : Color(0xFFC9CCD1)
                          )

                      ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          likeButton(),
                          ReactionsButton(text : ' Comment' ,icon : Icons.comment,setstat: commentButton)

                        ]
                    ),
                  ),

                ],

            ),
          ),

          Column(
            children: getCommentsCard(),
          ),


              Container(

              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextFormField(
                        controller: emailController,
                        maxLines: 2,
                        focusNode: myFocusNode,

                        style: TextStyle(
                          color: Colors.black,
                        ),

                        decoration: InputDecoration(
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: (){
                              comment();
                            },
                          ),
                          fillColor: Color(0xffF6F6FE),
                          prefixIcon: Icon(
                            Icons.comment,
                            color: Colors.grey,

                          ),

                          hintText: 'Your comment ...',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide:  BorderSide(color: Color(0xFFE3E4E9)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),

                        ),
                        onChanged: (value){
                            if((value.length != 0)){
                              print('You can  comment');
                            }
                        },
                      ),
                    ),

                 ]
                ),
              ),
            ),
           ]


      
      ),
    );
  }
}

