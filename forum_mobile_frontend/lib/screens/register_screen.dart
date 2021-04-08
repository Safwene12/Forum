
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum_mobile_frontend/contants/constants.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:forum_mobile_frontend/models/user.dart';
import 'package:forum_mobile_frontend/screens/login_screen.dart';
import 'package:forum_mobile_frontend/services/auth_service.dart';
import 'package:forum_mobile_frontend/widgets/login_button.dart';
import 'package:intl/intl.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final format = DateFormat("yyyy-MM-dd");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  void validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      print('valid');
      User user = User(
        name: fullnameController.text,
        username: usernameController.text,
        dateofbirth: dateOfBirthController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text,
      );
      register(user, context);
    } else {
      print('Form is invalid');
    }
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

                Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: LoginRegisterText('Register')
                ),
                TextField(
                  text: 'username',
                  controller: usernameController,
                  decoField: kLoginField,
                ),
                TextField(

                  text: 'password',
                  controller: passwordController,
                  decoField: kPasswordField,
                ),
                TextField(
                  text: 'Full Name',
                  controller: fullnameController,
                  decoField: kNameField,
                ),
                TextField(
                  text: 'E-mail',
                  controller: emailController,
                  decoField: kEmailField,
                ),
                TextField(
                  text: 'Phone',
                  controller: phoneController,
                  decoField: kPhoneField,
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 0),

                  child: DateTimeField(
                    controller: dateOfBirthController,
                    decoration: InputDecoration(

                      hintText: 'Date Of birth',
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
                      prefixIcon: Icon(
                        Icons.date_range,
                        color: Colors.grey,

                      ),
                    ),

                    format: format,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: LoginButton(
                    text: 'Register',
                    validateAndSave: validateAndSave
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children :[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 0, 10),
                        child: Text(
                            'A member?'
                        ),
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 10, 10),
                          child: Text(
                            ' Login',
                            style: TextStyle(
                              color: Color(0xFF0065FF),
                            ),
                          ),

                        ),
                        onTap: (){
                          Navigator.pop(context);
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

  Container TextField({String text, Function onTap, decoField,controller}) {
    return Container(
              height: 60,
              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: TextFormField(
                controller: controller,
                textAlignVertical: TextAlignVertical.bottom,
                validator: (value) =>
                value.isEmpty ? '$text cannot be blank' : null,
                style: TextStyle(
                  color: Colors.black,

                ),

                decoration: decoField,
                onChanged: (value){

                },
              ),
            );
  }

  Container TextPasField({String text, Function onTap, decoField,controller}) {
    return Container(
      height: 60,
      padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: TextFormField(
        enableSuggestions: false,
        autocorrect: false,
        obscureText: true,
        controller: controller,
        textAlignVertical: TextAlignVertical.bottom,
        validator: (value) =>
        value.isEmpty ? '$text cannot be blank' : null,
        style: TextStyle(
          color: Colors.black,

        ),

        decoration: decoField,
        onChanged: (value){

        },
      ),
    );
  }
}
