

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:servicehub/homepage/homepage.dart';


import '../homeanimation/homeanimation.dart';
import '../loginpage/loginpage.dart';

class AuthService {
  // ignore: non_constant_identifier_names
  AuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return homepage();
        } else {
          return loginpage();
        }
      },
    );
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();
    //obtaining the details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    //create new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      
      idToken: googleAuth.idToken,
    );
    //once signed in return the user credential
    return await FirebaseAuth.instance.signInWithCredential(credential);
   
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}