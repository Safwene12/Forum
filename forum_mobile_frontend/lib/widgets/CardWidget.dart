import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forum_mobile_frontend/contants/constants.dart';
import 'package:forum_mobile_frontend/models/post.dart';
import 'package:forum_mobile_frontend/screens/post_screen.dart';

num selectedPost;
Post post = Post();
class CardWidget extends StatefulWidget {
  int id;
  String username;
  String date;
  String cardTitle ;
  String cardText;
  num likeNumber;
  num commentaireNum;
  String userPicture;


  CardWidget(id,username,userPicture,date,cardTitle,cardText,commentaireNum,likeNumber){
    this.id=id;
    this.username=username;
    this.date=date;
    this.commentaireNum=commentaireNum;
    this.likeNumber=likeNumber;
    this.cardText=cardText;
    this.cardTitle=cardTitle;
    this.userPicture=userPicture;
  }





  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {




  

  @override
  Widget build(BuildContext context) {
    post.id = widget.id;

    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.all(20),
        color: Color(0xffF6F6FE),
        child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/${widget.userPicture}'),
                ),

                title: Text(
                  '${widget.username} ' ,
                  style: TextStyle(
                      color: kTextColor,
                      fontFamily: 'SourceSansPro',
                      fontSize: 20.0
                  ),
                ),
                subtitle: Text(
                  widget.date,
                  style: TextStyle(
                    color: kTextSecondaryColor,
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.cardTitle,
                        style: TextStyle(
                          color: kTextColor,
                        ),
                      ),
                      Text(
                        widget.cardText,
                        style: TextStyle(color: kTextSecondaryColor),
                      ),
                    ]
                ),
              ),

              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,


                children: [
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Icon(

                        Icons.favorite,
                        color: Color(0xFFe63946),
                      ),

                      Text(
                          ' ${widget.likeNumber} '
                      ),
                      Icon(
                        Icons.comment,
                        color: Color(0xFF0083FF),
                      ),
                      Text(
                          ' ${widget.commentaireNum} '
                      ),
                    ],
                  ),

                  Container(
                    child: FlatButton(

                      textColor: Color(0xFF617BF3),
                      onPressed: () {
                        // Perform some action

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return PostScreen(id:  widget.id);
                              })
                          );

                      },
                      child: Row(
                        children: [
                          Text('Join Form'),
                          Icon(Icons.navigate_next_rounded)
                        ],
                      ),

                    ),
                  ),
                ],
              ),
            ]
        ),


      ),
    );
  }
}
