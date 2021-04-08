import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

const kAppBarColor =Colors.white;
const kAppBarTextColor = Color(0xFF005FF9);
const kTextColor = Color(0xFF082F57);
const kTextSecondaryColor = Color(0xFFA9B5C8);
const kAppColor = Colors.white;

const kPostTextColor = Colors.black;


const kTextFieldInputDecoration = InputDecoration(
    filled: true,

    fillColor: Color(0xffF6F6FE),
    prefixIcon: Icon(
      Icons.search,
      color: Colors.grey,

    ),

    hintText: 'Search something ...',
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

);

var kCommentField = InputDecoration(
  filled: true,
  suffixIcon: IconButton(
    icon: Icon(Icons.send),
    onPressed: (){
      print("button pressed");
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

);
const kLoginField = InputDecoration(
  filled: true,

  fillColor: Colors.white,
  prefixIcon: Icon(
    Icons.person_outline_sharp,
    color: Colors.grey,

  ),

  hintText: 'Username',
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

);
const kTitleField = InputDecoration(
  filled: true,

  fillColor: Colors.white,


  hintText: 'Title',
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

);
const kPostField = InputDecoration(
  filled: true,

  fillColor: Colors.white,


  hintText: 'Post',
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

);
const kEmailField = InputDecoration(
  filled: true,

  fillColor: Colors.white,
  prefixIcon: Icon(
    Icons.alternate_email,
    color: Colors.grey,

  ),

  hintText: 'E-mail',
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

);
const kPhoneField = InputDecoration(
  filled: true,

  fillColor: Colors.white,
  prefixIcon: Icon(
    Icons.phone,
    color: Colors.grey,

  ),

  hintText: 'Phone',
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

);
const kNameField = InputDecoration(
  filled: true,

  fillColor: Colors.white,
  prefixIcon: Icon(
    Icons.person,
    color: Colors.grey,

  ),

  hintText: 'Full Name',
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

);
kTextField(String text) {
  InputDecoration(
    filled: true,

    fillColor: Colors.white,
    prefixIcon: Icon(
      Icons.person,
      color: Colors.grey,

    ),

    hintText: '$text',
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

  );
}
const kPasswordField = InputDecoration(
  filled: true,

  fillColor: Colors.white,
  prefixIcon: Icon(
    Icons.https_outlined,
    color: Colors.grey,

  ),

  hintText: 'Password',
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

);

Text LoginRegisterText(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(

      color: Color(0xFF13284A),

      fontSize: 30,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.italic,
    ),
  );
}

const spinkit = SpinKitRotatingCircle(
  color: Colors.white,
  size: 50.0,
);