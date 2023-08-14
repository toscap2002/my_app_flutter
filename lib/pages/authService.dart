import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class AuthService extends ChangeNotifier{
  //istanza di autenticazione
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //istanza di firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

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

      //aggiungere un documento per l'utente nella collezione 'user' se non esiste già
      _fireStore.collection('user').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email' : email,
      }, SetOptions(merge: true));



      return userCredential;
    } on FirebaseException catch (e){
      throw Exception(e.code);
    }
  }

  //creare un nuovo utente
  Future<UserCredential> signUpWithEmailandPassword(String email, String password, String name) async{
    try {

      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );

      //dopo aver creato un utente,
      //creiamo un documento per l'utente nella collezione degli utenti
      _fireStore.collection('user').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email' : email,
        'name' : name,
      });

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