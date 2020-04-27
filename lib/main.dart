import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ideaevaluator/src/firebase/account.dart';
import 'package:ideaevaluator/src/pages/eventlist.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'src/welcomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return StreamProvider<FirebaseUser>.value(
      value: Accounts().account,
      child: MaterialApp(
        routes: {
          '/home' : (context) => Home(),
          '/events' : (context) => Events(),
          '/welcome' : (context) => WelcomePage(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
           primarySwatch: Colors.blue,
           textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
             body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
           ),
        ),
        debugShowCheckedModeBanner: false,
        home: WelcomePage(),
      ),
    );
  }
}