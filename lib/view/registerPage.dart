import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/view-model/components/button.dart';
import 'package:my_app_flutter/view-model/components/logo.dart';
import 'package:my_app_flutter/view-model/components/textfield.dart';
import 'package:my_app_flutter/view-model/authService.dart';
import 'package:my_app_flutter/view/tutorialPage.dart';
import 'package:provider/provider.dart';


class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState  extends State<RegisterPage> {
  //text editing controller
  final tagController = TextEditingController();
  final nameController = TextEditingController();
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

    // Controlla se email, nome e password non sono vuoti
    if (emailController.text.isEmpty ||
        nameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      // Pop il cerchio di caricamento
      Navigator.pop(context);

      // Mostra un messaggio di errore
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Tutti i campi devono essere compilati"
              "\nIl Nick può essere inserito successivamente"),
        ),
      );
      return;
    }

    //controllare se la password è confermata
    if (passwordController.text != confirmPasswordController.text) {
      // Pop il cerchio di caricamento
      Navigator.pop(context);

      // Mostra un messaggio di errore
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password Errata"),
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
        nameController.text,
        tagController.text,
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
                          controller: tagController,
                          hintText: 'Tag',
                          obscureText: false,
                        ),

                        const SizedBox(height: 10),

                        MyTextField(
                          controller: nameController,
                          hintText: 'Nome',
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
                            MouseRegion(
                              cursor: SystemMouseCursors.click, // Imposta il cursore su "mano"
                              child: GestureDetector(
                                onTap: widget.onTap,
                                child: const Text(
                                  'Fai il login',
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