import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier{
  //istanza di autenticazione
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //istanza di realtime database
  final FirebaseDatabase _database = FirebaseDatabase.instance;

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

  //creare un nuovo utente
  Future<UserCredential> signUpWithEmailandPassword(String email, password, name, tag) async{
    try {

      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );

      // Aggiungi i dati dell'utente nel database Realtime
      if (userCredential.user != null) {
        final userId = userCredential.user!.uid;
        var apiKey = "";
        _database.reference().child('user').child(userId).set({
          'uid': userCredential.user!.uid,
          'email': email,
          'name': name,
          'tag' : tag,
          'apiKey' : apiKey,
        });
      }
      return userCredential;
    } on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  //Uscire dall'account
    Future<void> logoutUser()  async{
      return await FirebaseAuth.instance.signOut();

    }
}