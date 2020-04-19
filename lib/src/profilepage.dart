import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ideaevaluator/src/firebase/firestore.dart';
import 'dart:ui' as ui;
import 'package:ideaevaluator/src/welcomePage.dart';
import 'package:provider/provider.dart';

//import 'package:flutter_login_signup/src/welcomePage.dart';

class MyHomePage extends StatefulWidget {

  final String title='Profile';

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map userData = {};

  Future setup(FirebaseUser user) async{
    userData = await AccountInfo(user).userInfo();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final String imgUrl = 'https://scontent-del1-1.xx.fbcdn.net/v/t1.0-9/s960x960/47076705_300676554111412_2898229581855064064_o.jpg?_nc_cat=105&_nc_ohc=27HKn-5Yso8AX8G2I3p&_nc_ht=scontent-del1-1.xx&_nc_tp=7&oh=a7a95b441fc38e1039649758b583a9d9&oe=5EFC361E';
    final String drawerImgUrl = 'https://ak9.picdn.net/shutterstock/videos/1024107419/thumb/1.jpg';
    var column = Column(children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(drawerImgUrl),
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(imgUrl),
                  ),
                  accountEmail: Text('${Provider.of<FirebaseUser>(context).email}',style: TextStyle(color: Colors.black),),
                  accountName: Text('${userData['userName']}',style: TextStyle(color: Colors.black),),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                ListTile(
                  onTap: (){
                    Navigator.of(context).pushNamed('/events');
                  },
                  title: Text('Home'),
                  leading: Icon(Icons.home),
                ),
                ListTile(
                  title: Text('Profile'),
                  leading: Icon(Icons.account_circle),
                ),
                ListTile(
                  title: Text('Setting'),
                  leading: Icon(Icons.settings),
                ),
                ListTile(
                  title: Text('Logout'),
                  leading: Icon(Icons.settings_power),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  }
                )
              ],);
    return FutureBuilder(
      future: setup(Provider.of<FirebaseUser>(context)),
      builder: (context, snapshot){
        return Stack(children: <Widget>[
          new Container(color: Colors.blue,),
          new Image.network(imgUrl, fit: BoxFit.fill,),
          new BackdropFilter(
              filter: new ui.ImageFilter.blur(
                sigmaX: 6.0,
                sigmaY: 6.0,
              ),
              child: new Container(
                decoration: BoxDecoration(
                  color:  Colors.blue.withOpacity(0.9),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),)),
          new Scaffold(
              appBar: new AppBar(
                title: new Text(widget.title),
                centerTitle: false,
                elevation: 0.0,
                backgroundColor: Colors.transparent,
              ),
              drawer: new Drawer(
                  child:column
              ),
              backgroundColor: Colors.transparent,
              body: new Center(
                child: new Column(
                  children: <Widget>[
                    new SizedBox(height: _height/12,),
                    new CircleAvatar(radius:_width<_height? _width/4:_height/4,backgroundImage: NetworkImage(imgUrl),),
                    new SizedBox(height: _height/25.0,),
                    new Text('${userData['userName']}', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: _width/15, color: Colors.white),),
                    new Padding(padding: new EdgeInsets.only(top: _height/30, left: _width/8, right: _width/8),
                      child:new Text('Developer, Enthusiast and a curious human.\nphotographer,pefectionist ',
                        style: new TextStyle(fontWeight: FontWeight.normal, fontSize: _width/25,color: Colors.white),textAlign: TextAlign.center,) ,),
                    new Divider(height: _height/30,color: Colors.white,),
                    new Row(
                      children: <Widget>[
                        rowCell(15,'POSTS'),
                        rowCell(673, 'FOLLOWERS'),
                        rowCell(275, 'FOLLOWING'),
                      ],),
                    new Divider(height: _height/30,color: Colors.white),
                    new Padding(padding: new EdgeInsets.only(left: _width/8, right: _width/8), child: new FlatButton(onPressed: (){},
                      child: new Container(child: new Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                        new Icon(Icons.person),
                        new SizedBox(width: _width/30,),
                        new Text('FOLLOW')
                      ],)),color: Colors.blue[50],),),
                  ],
                ),
              )
          )
        ],
        );
      },
    );
  }

  Widget rowCell(int count, String type) => new Expanded(child: new Column(children: <Widget>[
    new Text('$count',style: new TextStyle(color: Colors.white),),
    new Text(type,style: new TextStyle(color: Colors.white, fontWeight: FontWeight.normal))
  ],));
}

