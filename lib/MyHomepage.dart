import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providerexam.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("building My app ");
    return ChangeNotifierProvider(
        create: (context) => CounterData(), lazy: false, child: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("building my homepage");

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Test App"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.purple])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
            ),
            RaisedButton(
                color: Colors.purple,
                child: Text(
                  "Fetch data from Firebase Cloud Storage",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Userdataupload();
                  }));
                }),
            Container(
              height: 200,
            ),
            Text(
              'You have pushed the button this many times:',
              style: TextStyle(color: Colors.white),
            ),
            Consumer<CounterData>(
              builder: (_, data, __) {
                return Text(
                  '${data.countnum}',
                  style: TextStyle(color: Colors.white, fontSize: 50),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer<CounterData>(
        builder: (_, data, __) {
          return FloatingActionButton.extended(
            heroTag: "buttn2",
            onPressed: data.increment,
            tooltip: 'Increment',
            label: Text("Press to increment "),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Userdataupload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("adding data to firbase after building layout");

    return Scaffold(
      appBar: AppBar(
        title: Text("Userdata"),
        backgroundColor: Colors.purple,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.purple,
          label: Text("Press to SignOut"),
          onPressed: () {
            FirebaseAuth.instance.signOut();
          }),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [Colors.blue, Colors.purple])),
        child: Listview(),
      ),
    );
  }
}

class Listview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("reached to stream builder");
    return StreamBuilder<QuerySnapshot>(
      stream: ref.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text("Loading"));
        }

        return snapshot.data.docs == null
            ? Center(
                child: Text("no data"),
              )
            : ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: new ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            NetworkImage(document.data()['photoUrl']),
                      ),
                      tileColor: Colors.white30,
                      title: new Text(document.data()['username']),
                      subtitle: new Text(document.data()['email']),
                    ),
                  );
                }).toList(),
              );
      },
    );
  }
}
