import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:providerexample/MyHomepage.dart';
import 'login.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User> snapshot) {
          print("Checking started");
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("waiting");
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Login();
          }
          return MyApp();
        });
  }
}
