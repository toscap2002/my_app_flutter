import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/button.dart';
import 'package:my_app_flutter/components/logo.dart';
import 'package:my_app_flutter/components/textfield.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState  extends State<LoginPage>{

  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //metodo per loggarsi
  void loginUser() async{
    //cerchio di caricamento
    showDialog(context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),
      );
    },
    );
    
    //cerca di entrare
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop the laging circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e){
      //pop the laging circle
      Navigator.pop(context);
      //email sbagliata
      if (e.code == 'user-not.found'){
        //mostra il messaggio all'utente
        wrongEmailMessage();
      }

      //password sbagliata
      else if (e.code == 'wrong-password'){
       //mostra il messaggio di errore all'utente
        wrongPasswordMessage();
      }
    }
  }

  //messaggio di email errata
  void wrongEmailMessage(){
    showDialog(
        context: context,
        builder: (context){
         return const AlertDialog(
            title: Text('Email errata'),
          );
        },
        );
  }

  //messaggio di errore per la password errata
  void wrongPasswordMessage(){
    showDialog(
      context: context,
      builder: (context){
        return const AlertDialog(
          title: Text('Password errata'),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const SizedBox(height: 50),
                //logo
                Logo(),
                // const Icon(
                //   Icons.lock,
                //   size : 100,
                // ),


                const SizedBox(height: 50),
                
                // //Bentornato
                // Text('Bentornato!',
                //   style: TextStyle(
                //       color: Colors.grey[50],
                //       fontSize: 16,
                //   ),
                // ),

                const SizedBox(height: 25),

                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                //password textflied
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                //Password dimenticata?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Password dimenticata?',
                            style: TextStyle(color: Colors.purple),
                          )
                        ]
                    )
                ),

                const SizedBox(height: 25),

                //Login
                MyButton(
                  onTap: loginUser,
                ),

                const SizedBox(height: 25),

                //non sei ancora registrato? registrati ora
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'non sei ancora registrato?',
                        style: TextStyle(color: Colors.purple),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Registrati',
                        style: TextStyle(
                        color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                )

                ])


      )
      )
          );
  }
}