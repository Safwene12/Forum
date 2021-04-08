import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

SizedBox LoginButton({Function validateAndSave, String text}) {
  return SizedBox(
    width: double.infinity,
    height: 45,
    child: ElevatedButton (

      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF0065FF)),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20.0,
            color: Colors.white
        ),
      ),
      onPressed: validateAndSave,
    ),
  );
}