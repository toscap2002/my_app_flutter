import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
final user = FirebaseAuth.instance.currentUser!;

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Profile Page
      backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        title: Text('Profilo'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      //backgroundColor: Colors.grey.shade600,
      body: ListView(
        children: [
          const SizedBox(height: 50),

          //profile pic
          Icon(Icons.person, size: 72),
          //user email
          Text(
            user.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          //user detail
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Dettagli',
              style: TextStyle(color: Colors.black),
            ),
          ),
          //bio
        ],

      ),
      );
  }
}
