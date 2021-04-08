import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forum_mobile_frontend/contants/constants.dart';
import 'package:forum_mobile_frontend/screens/main_screen.dart';
import 'package:forum_mobile_frontend/screens/post_screen.dart';
import 'package:forum_mobile_frontend/services/comment_service.dart';
import 'package:google_fonts/google_fonts.dart';
class CommentWidget extends StatelessWidget {


  int id ;
  String username;
  String date;
  String text;
  String image;
  CommentWidget({this.id,this.username,this.text,this.date,this.image});
  @override
  Widget build(BuildContext context) {
    deleteComment() async{
      CommentService service = CommentService();
      print(id);
      await service.deleteComment(id, context);

    }
    return Padding(
      padding: EdgeInsets.fromLTRB(10,10,10,5),
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/$image'),
              ),

              title: Row(

                children: [
                  Text(
                    username,
                    style: TextStyle(
                      color: kPostTextColor,
                      fontFamily: 'SourceSansPro',
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  IconButton(
                      onPressed: (){
                        deleteComment();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context){
                              return MainScreen();
                            })
                        );

                      },
                      icon: Icon(
                        Icons.delete_outline,
                      )
                  )
                ]
              ),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        color: kTextSecondaryColor,
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,10,0,10),
                      child: Text(
                        text,
                        style: GoogleFonts.roboto(
                          color: kPostTextColor,
                          fontSize: 15,
                          //fontWeight: FontWeight.w700,
                          //fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ]
              ),
            ),

          ],
        ),
      ),
    );
  }
}
