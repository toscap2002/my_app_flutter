import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/button.dart';
import 'package:my_app_flutter/components/logo.dart';
import 'package:my_app_flutter/components/textfield.dart';

class LoginPage extends StatelessWidget{
  LoginPage({super.key});

  //text editing controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
                
                //Bentornato
                Text('Bentornato!',
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
                  onTap: singUserIn,
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