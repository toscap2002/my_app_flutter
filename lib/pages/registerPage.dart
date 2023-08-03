import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/button.dart';
import 'package:my_app_flutter/components/logo.dart';
import 'package:my_app_flutter/components/textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState  extends State<RegisterPage>{

  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //metodo per registrarsi
  void signUserUp() async{
    //cerchio di caricamento
    showDialog(context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),
      );
    },
    );

    //l'utente si registra
    try{
      //controllare se la password è confermata
      if(passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        //mostra un messaggio di errore, le password non sono uguali
        showErrorMessage("Password diversa!");
      }
      //pop the laging circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e){
      //pop the laging circle
      Navigator.pop(context);
      //mostra il messagiio di errore
      showErrorMessage(e.code);
    }
  }

  //messaggio di errore
  void showErrorMessage(String message){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: Colors.deepPurpleAccent,
          title: Center(
            child: Text(message,
              style: TextStyle(color: Colors.white),),
          ),
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
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 25),
                        //logo
                        Logo(),
                        // const Icon(
                        //   Icons.lock,
                        //   size : 100,
                        // ),


                        const SizedBox(height: 25),

                        //crea un account
                        Text('Crea un account!',
                          style: TextStyle(
                              color: Colors.grey[50],
                              fontSize: 16,
                          ),
                        ),

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

                        const SizedBox(height: 10),

                        //conferma password textflied
                        MyTextField(
                          controller: confirmPasswordController,
                          hintText: 'Conferma Password',
                          obscureText: true,
                        ),

                        const SizedBox(height: 25),

                        //Login
                        MyButton(
                          text: "Registrati",
                          onTap: signUserUp,
                        ),

                        const SizedBox(height: 25),

                        //sei già registrato? fai il login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sei già registrato?',
                              style: TextStyle(color: Colors.purple),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                                onTap: widget.onTap,
                                child: const Text(
                                  'Fai il login',
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