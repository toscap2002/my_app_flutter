import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  
  //Metodo di logout
  void logoutUser(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: logoutUser,
              icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(child: Text("Sei entrato come " + user.email!,
      style: TextStyle(fontSize: 20),
      ),
      )
    );
  }
}