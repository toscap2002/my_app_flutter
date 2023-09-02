import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/view-model/introPage.dart';
import 'package:my_app_flutter/view/loginPage.dart';
import 'package:my_app_flutter/view/homePage.dart';
import 'package:my_app_flutter/view-model/loginOregistrati.dart';

class AuthPage extends StatelessWidget{
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //l'utente è loggato
          if (snapshot.hasData){
            return IntroPage();
          }
          //l'utente NON è loggato
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}