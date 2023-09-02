import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/view-model/components/button.dart';
import 'package:my_app_flutter/view-model/components/logo.dart';
import 'package:my_app_flutter/view-model/components/textfield.dart';
import 'package:my_app_flutter/view-model/authService.dart';
import 'package:my_app_flutter/view/forgotPassword.dart';
import 'package:my_app_flutter/view/tutorialPage.dart';
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
                                MouseRegion(
                                  cursor: SystemMouseCursors.click, // Cursore a forma di mano
                                  child: GestureDetector(
                                    onTap: () {
                                      // Azione da eseguire quando si fa clic sul testo "Password dimenticata"
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return ForgotPasswordPage();
                                      }));
                                    },
                                    child: Text('Password dimenticata?',
                                      style: TextStyle(color: Colors.purple),
                                    ),
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
                            MouseRegion(
                              cursor: SystemMouseCursors.click, // Cursore a forma di mano
                              child: GestureDetector(
                                onTap: widget.onTap,
                                child: Text(
                                  'Registrati',
                                  style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // //Tutorial
                        // MyButton(
                        //   text: "Tutorial",
                        //   onTap:() {
                        //     // Quando il pulsante viene premuto, apri la nuova pagina
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => TutorialPage()),
                        //     );
                        //   },
                        // ),
                        ElevatedButton(
                            onPressed: () {
                              // Quando il pulsante viene premuto, apri la nuova pagina
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TutorialPage()),
                              );
                            },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pinkAccent[400], // Colore di sfondo del pulsante
                            onPrimary: Colors.white, // Colore del testo del pulsante
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8), // Bordo arrotondato
                            ),
                            padding: const EdgeInsets.all(25),
                          ),
                            child: const Text(
                              'Tutorial',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                        ),
                          ],
                  ),
                )

            )
        )
    );
  }
}