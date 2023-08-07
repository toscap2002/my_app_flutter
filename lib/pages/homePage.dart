import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.pinkAccent,
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
      ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.grey.shade800,
          color: Colors.pinkAccent,
          animationDuration: Duration(milliseconds: 300),
          onTap: (index){
            print(index);
          },
          items: [
            Icon(
                Icons.search,
                color: Colors.white,
            ),
            Icon(
                Icons.local_fire_department_sharp,
                color: Colors.white,
            ),
      ],
    ),
    );
  }
}