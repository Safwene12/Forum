
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum_mobile_frontend/contants/constants.dart';
import 'package:forum_mobile_frontend/screens/register_screen.dart';
import 'package:forum_mobile_frontend/services/auth_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool isLoading = false ;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  void validateAndSave() async{


  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(

          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image(
                    image: AssetImage('assets/images/register.PNG'),

                ),
                Padding(
                  padding: EdgeInsets.only(top:0),
                  child: LoginRegisterText('Login'),
                ),
                Container(
                  height: 75,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    controller: emailController,
                    style: TextStyle(
                      color: Colors.black,

                    ),

                    decoration: kLoginField,
                    onChanged: (value){

                    },
                  ),
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.fromLTRB(15, 0, 15,15),
                  child: TextFormField(

                    textAlignVertical: TextAlignVertical.bottom,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    controller: passController,
                    style: TextStyle(
                      color: Colors.black,
                    ),

                    decoration: kPasswordField,
                    onChanged: (value){

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: SizedBox(
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
                        'Login',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white
                        ),
                      ),
                      onPressed : (){
                        if(emailController.text=="" || passController.text =="" ){
                          print('sss');
                        }
                        else{
                          setState(() {
                            isLoading = true;
                          });
                          signIn(emailController.text, passController.text , context);
                          print('Button pressed');
                        }
                      }
                    ),
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children :[
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 15, 0, 10),
                      child: Text(
                          'New to Forum?'
                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 10, 10),
                        child: Text(
                            ' Register',
                            style: TextStyle(
                              color: Color(0xFF0065FF),
                            ),
                        ),

                      ),
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context){
                              return RegisterScreen();
                            })
                        );
                      },
                    ),
                  ]
                )
              ],
            ),
          ),
        ),
      ),
    );
  }




}
