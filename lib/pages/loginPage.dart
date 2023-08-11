import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/button.dart';
import 'package:my_app_flutter/components/logo.dart';
import 'package:my_app_flutter/components/textfield.dart';
import 'package:my_app_flutter/pages/authService.dart';
import 'package:my_app_flutter/pages/forgotPassword.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState  extends State<LoginPage>{

  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //metodo per loggarsi
  void loginUser() async{
    //prende l'autenticazione
    final authService = Provider.of<AuthService>(context, listen: false);
    //cerchio di caricamento
    showDialog(context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),
      );
    },
    );

    //cerca di entrare
    try{
      await authService.signInWithEmailandPassword(
          emailController.text,
          passwordController.text,
      );

     //pop the laging circle
      Navigator.pop(context);
    } catch (e){
      //pop the laging circle
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ),
      );
    }
  }

  // //messaggio di errore
  // void showErrorMessage(String message){
  //   showDialog(
  //       context: context,
  //       builder: (context){
  //        return AlertDialog(
  //          backgroundColor: Colors.deepPurpleAccent,
  //           title: Center(
  //             child: Text(message,
  //               style: TextStyle(color: Colors.white),),
  //           ),
  //           );
  //
  //       },
  //       );
  // }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const SizedBox(height: 50),
                  //logo
                  Logo(),


                  const SizedBox(height: 25),
                  
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return ForgotPasswordPage();
                                    }));
                              },
                              child: Text('Password dimenticata?',
                              style: TextStyle(color: Colors.purple),
                            ),
                            ),
                          ],
                      )
                  ),

                  const SizedBox(height: 25),

                  //Login
                  MyButton(
                    text: "Login",
                    onTap: loginUser,
                  ),

                  const SizedBox(height: 25),

                  //non sei ancora registrato? registrati ora
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Non sei ancora registrato?',
                          style: TextStyle(color: Colors.purple),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.onTap,
                        child: const Text(
                          'Registrati',
                          style: TextStyle(
                          color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        ),
                      ],
                  )

                  ]),
          )


      )
      )
          );
  }
}