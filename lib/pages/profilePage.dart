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
      appBar: AppBar(
        title: Text('Profilo'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      //backgroundColor: Colors.grey.shade600,
      body: Center(child: Text("Sei entrato come " + user.email!,
        style: TextStyle(fontSize: 20),

      ),
      ),
    );
  }
}
