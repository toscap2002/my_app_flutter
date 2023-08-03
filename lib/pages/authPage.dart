import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/pages/loginPage.dart';
import 'package:my_app_flutter/pages/homePage.dart';

class AuthPage extends StatelessWidget{
  const AuthPage({super.key});

  @override
  Widget build(BuildContext xontext){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //l'utente è loggato
          if (snapshot.hasData){
            return HomePage();
          }
          //l'utente NON è loggato
          else {
            return LoginPage();
          }

        },
      ),
    );
  }
}