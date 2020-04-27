import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Hurrah'),
      content: Text('Successfuly Registered for the event'),
      actions: <Widget>[
        RaisedButton(
          onPressed: (){
            setState(() {
              Navigator.of(context).pop();
            });
          },
          child: Text('OK'),
        )
      ],
    );
  }
}

