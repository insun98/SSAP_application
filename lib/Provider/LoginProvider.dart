import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';


import '../firebase_options.dart';
import '../src/login.dart';

class LoginProvider extends ChangeNotifier {
  login _loginType = login.logout;
  login get loginType => _loginType;
  String defaultImage =
      "https://firebasestorage.googleapis.com/v0/b/final-project-eedb4.appspot.com/o/defaultimage.png?alt=media&token=b289c8b8-11ce-463a-95a8-ac92cda654f2";


  Future<bool> signInAsGuest() async {
    bool user = false;
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      user = true;

      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unkown error.");
      }
    }
    // FirebaseFirestore.instance
    //     .collection('user')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .set(<String, dynamic>{
    //   'email': "Anonymous",
    //   'name': "Hadong",
    //   'image': defaultImage,
    //   'state_message': 'I promise to take the test honestly before God',
    //   'uid': FirebaseAuth.instance.currentUser!.uid,
    // });
    _loginType = login.anonymous;
    notifyListeners();

    return user;
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
