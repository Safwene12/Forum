import 'package:flutter/material.dart';
import 'package:forum_mobile_frontend/contants/constants.dart';

FloatingActionButton AddButton() {
  return FloatingActionButton(
    backgroundColor: kAppBarTextColor,
    tooltip: 'Increment',
    child: Icon(Icons.add),
    onPressed: (){

    },
  );
}