import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

var user = FirebaseAuth.instance.currentUser;
CollectionReference ref = FirebaseFirestore.instance.collection('User');
CounterData dataaa = new CounterData();

class CounterData extends ChangeNotifier {
  //this is for increment of counter
  int countnum = 0;
  increment() {
    countnum++;
    notifyListeners();
  }

  //checking whether user is logged or not
  bool isLoggedIn() {
    if (user != null) {
      return true;
    }
    return false;
  }

  //For adding data
  Future<void> adddata(userdata) async {
    if (isLoggedIn()) {
      FirebaseFirestore.instance
          .collection('$User')
          .doc('${user.uid}')
          .set(userdata);
    } else {
      print("you need to logIn");
    }
  }

  //user data modal
  var userdata = {
    'username': user.displayName,
    'email': user.email,
    'photoUrl': user.photoURL,
    'id': user.uid,
    'address': {'city': "Chittorgarh", 'area': "pratapnagar"}
  };
}

Future<String> gSignInFunction() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignInAccount googleuser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleuser.authentication;
  // ignore: deprecated_member_use
  final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final User currentUser = _auth.currentUser;
  assert(user.uid == currentUser.uid);
  dataaa.adddata(dataaa.userdata).then((result) {
    print("Done");
  }).catchError((e) {
    print(e);
  });

  return 'signInWithGoogle succeeded: $user';
}
