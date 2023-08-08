import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  //istanzia l'autenticazione
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //accedere
  Future<UserCredential> signInWithEmailandPassword(String email, String password) async {
    try{
      //accede
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
      );
      return userCredential;
    } on FirebaseException catch (e){
      throw Exception(e.code);
    }
  }

  //uscire
}