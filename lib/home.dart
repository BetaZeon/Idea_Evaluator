import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ideaevaluator/src/firebase/account.dart';
import 'package:ideaevaluator/src/firebase/firestore.dart';
import 'package:ideaevaluator/src/pages/eventlist.dart';
import 'package:ideaevaluator/src/profilepage.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map userData = {};
  Accounts _account = Accounts();
  dynamic body =  MyHomePage();
  String imgUrl;
  final String drawerImgUrl = 'https://ak9.picdn.net/shutterstock/videos/1024107419/thumb/1.jpg';

  Future setup(FirebaseUser user) async{
    userData = await AccountInfo(user).userInfo();
    imgUrl = await AccountInfo(user).getProfileImage();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: setup(Provider.of<FirebaseUser>(context)),
        builder: (context, snapshot){
          return Scaffold(
            drawer: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(drawerImgUrl),
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(imgUrl != null ? imgUrl : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png'),
                    ),
                    accountEmail: Text('${Provider.of<FirebaseUser>(context) != null ? Provider.of<FirebaseUser>(context).email : "Not Logged In"}',style: TextStyle(color: Colors.black),),
                    accountName: Text('${userData['userName']}',style: TextStyle(color: Colors.black),),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  ListTile(
                    title: Text('Home'),
                    leading: Icon(Icons.home),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                      setState(() {
                        Navigator.of(context).pop();
                        body = Events();
                      });
                      //Navigator.of(context).pushNamed('/events');
                    },
                  ),
                  ListTile(
                    title: Text('Profile'),
                    leading: Icon(Icons.account_circle),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                      setState(() {
                        Navigator.of(context).pop();
                        body = MyHomePage();
                      });
                      //Navigator.of(context).pushNamed('/home');
                    },
                  ),
                  ListTile(
                    title: Text('Settings'),
                    leading: Icon(Icons.settings),
                    onTap: () {
                      //Update the state of the app.
                      // ...
                      setState(() {
                        Navigator.of(context).pop();
                        //body = Settings();
                      });
                      //Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.settings_power),
                    onTap: () async{
                      //Update the state of the app.
                      //...
                      dynamic result = await _account.signOut();
                      print(result);
                      if(result != null) {
                        Navigator.of(context).pushReplacementNamed('/welcome');
                      }
                    },
                  ),
                ],
              ),
            ),
            body: body,
          );
        }
    );
  }
}
