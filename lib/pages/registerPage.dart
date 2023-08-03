import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/button.dart';
import 'package:my_app_flutter/components/logo.dart';
import 'package:my_app_flutter/components/textfield.dart';

class RegisterPage extends StatelessWidget{
  RegisterPage({super.key});

  //text editing controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //metodo per registrarsi
  void singUserIn() {}

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

                      //Registrati
                      Text('Registrati!',
                        style: TextStyle(
                            color: Colors.grey[50],
                            fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 25),

                      //username textfield
                      MyTextField(
                        controller: usernameController,
                        hintText: 'Username',
                        obscureText: false,
                      ),

                      const SizedBox(height: 25),

                      //username textfield
                      MyTextField(
                        controller: confirmPasswordController,
                        hintText: 'Conferma password',
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

                      //Registrati
                      MyButton(
                        onTap: singUserIn,
                      ),

                      const SizedBox(height: 25),

                      //non sei ancora registrato? registrati ora
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sei già registrato?',
                            style: TextStyle(color: Colors.purple),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Login',
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