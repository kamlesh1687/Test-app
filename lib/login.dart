import 'package:flutter/material.dart';
import 'package:providerexample/providerexam.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Reached to login screen');
    return MaterialApp(
        home: Scaffold(
            body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, Colors.teal]),
      ),
      child: Center(
        child: RaisedButton(
          animationDuration: Duration(seconds: 3),
          color: Colors.teal,
          child: Text(
            "LogIn",
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
          onPressed: () async {
            gSignInFunction();
          },
        ),
      ),
    )));
  }
}
