import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sofigram/screens/feed_screen.dart';
import 'package:sofigram/screens/login_screen.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;
  static void singUpUser(
      BuildContext context, String name, String email, String password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser signedInUser = authResult.user;
      if (signedInUser != null) {
        _firestore
            .collection('/users')
            .document(signedInUser.uid)
            .setData({'name': name, 'email': email, 'profileImageUrl': ''});
            Navigator.pushReplacementNamed(context, FeedScreen.id);
      }
    } catch (e) {
      print(e);
    }
  }

  static void logOut(BuildContext context, ){
    _auth.signOut();
    Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  static void logIn(BuildContext context, String email, String password) async{
   try{
     await _auth.signInWithEmailAndPassword(email: email, password: password);
    Navigator.pushReplacementNamed(context, FeedScreen.id);}
    catch(e){
      print(e);
    }
  }
}
