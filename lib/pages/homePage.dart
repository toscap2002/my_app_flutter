import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app_flutter/pages/authService.dart';


class HomePage extends StatefulWidget{
   HomePage({super.key});

   @override
   _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

final user = FirebaseAuth.instance.currentUser!;


  //Metodo di logout
  void logoutUser() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.logoutUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            onPressed: logoutUser,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(child: Text("Sei entrato come " + user.email!,
      style: TextStyle(fontSize: 20),

    ),
    ),
    );

  }
}


