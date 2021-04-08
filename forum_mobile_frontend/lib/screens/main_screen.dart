import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forum_mobile_frontend/contants/constants.dart';
import 'package:forum_mobile_frontend/models/user.dart';
import 'package:forum_mobile_frontend/screens/home_screen.dart';
import 'package:forum_mobile_frontend/screens/login_screen.dart';
import 'package:forum_mobile_frontend/screens/new_post.dart';
import 'package:forum_mobile_frontend/screens/profile_screen.dart';
import 'package:forum_mobile_frontend/services/user_service.dart';
import 'package:forum_mobile_frontend/widgets/add_button_widget.dart';
import 'package:forum_mobile_frontend/widgets/app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

int _selectedIndex = 0;
const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
 List<Widget> _widgetOptions = <Widget>[
   HomeScreen(),
   ProfileScreen()
];

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  User user = User(name: 'Username');
  void getUser() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int id = int.parse(sharedPreferences.getString('id'));
    UserService service = UserService();
    User u = await service.getUserById(context, id);
    setState(() {
      user=u;
    });
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  logOut(context) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('token');

    Navigator.push(context,
        MaterialPageRoute(builder: (context){
          return LoginScreen();
        })
    );

  }
  @override
  void initState() {
    getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.

          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(

                child: Center(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(

                              decoration: BoxDecoration(

                                shape: BoxShape.circle,
                                image: DecorationImage(

                                    image: AssetImage('assets/images/default.jpg'),
                                    fit: BoxFit.fill
                                ),
                              ),

                            ),
                          ),
                          Expanded(child: Padding(
                            padding: EdgeInsets.only(top: 5),
                              child: Text(user.name ),
                          ),
                          )
                        ]

                    ),


                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Log out'),
                onTap: () {
                  logOut(context);

                },
              ),

            ],
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
        leading: new IconButton(
        icon: new Icon(Icons.menu),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
          title: Text(
            'Aymax Forum',

            style: TextStyle(
              color: kAppBarColor,
              fontFamily: "Roboto-Regular",
            ),
          ),
          backgroundColor: kAppBarTextColor,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0XffA2B1F3),
          onTap: _onItemTapped,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kAppBarTextColor,
          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context){
                  return NewPost();
                })
            );
          },
          child: Icon(
            Icons.add,
          ),
        )
      ),
    );
  }


}
