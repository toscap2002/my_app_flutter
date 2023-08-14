import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/button.dart';
import 'package:my_app_flutter/components/logo.dart';
import 'package:my_app_flutter/components/textfield.dart';
import 'package:my_app_flutter/pages/authService.dart';
import 'package:provider/provider.dart';


class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState  extends State<RegisterPage> {
  //text editing controller
  final userNameController = TextField();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //metodo per registrarsi
  void signUserUp() async {
    //cerchio di caricamento
    showDialog(context: context, builder: (context) {
      return Center(child: CircularProgressIndicator(),
      );
    },
    );
    //controllare se la password è confermata
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password sbagliata"),
        ),
      );
      return;
    }
    //prendiamo l'autorizzazione da auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailandPassword(
        emailController.text,
        passwordController.text,
      );
      //pop the laging circle
      Navigator.pop(context);
    } catch (e) {
      //pop the laging circle
      Navigator.pop(context);
      //mostra il messagiio di errore
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ),
      );
    };
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

                        MyTextField(
                          controller: userNameController,
                          hintText: 'Username',
                          obscureText: false,
                        ),

                        const SizedBox(height: 10),

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