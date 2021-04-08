import 'package:flutter/material.dart';

class ReactionsButton extends StatefulWidget {
  @override
  _ReactionsButtonState createState() => _ReactionsButtonState();
   String text;
   IconData icon ;
   Function setstat;
  ReactionsButton({ text,  icon, setstat}){
    this.text = text;
    this.icon = icon;
    this.setstat = setstat;
  }
}

class _ReactionsButtonState extends State<ReactionsButton> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Row(
          children: [
            Icon(
              widget.icon,

            ),
            Text(
              widget.text,
              style: TextStyle(

              ),
            )
          ],
        ),
        onPressed: widget.setstat,
         hoverColor: Color(0xFF056BE1),
    );;
  }
}


class LikeButton extends StatelessWidget {
  LikeButton({this.icon , this.text , this.setstat});
  final IconData icon;
  final String text ;
  final Function setstat;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Row(
          children: [
            Icon(
              icon,
              color: Color(0xFF056BE1),
            ),
            Text(
              text,
              style: TextStyle(
                color: Color(0xFF056BE1),
              ),
            )
          ],
        ),
        onPressed:setstat,
      hoverColor: Color(0xFF056BE1),

    );
  }
}

