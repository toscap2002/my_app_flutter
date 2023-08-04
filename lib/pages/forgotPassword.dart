import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/button.dart';
import 'package:my_app_flutter/components/textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim());
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text('Il link per modificare la password è stato inviato!! Controlla nella tua email'),
          );
        },
      );
    } on FirebaseAuthException catch (e){
      print(e);
      showDialog(
          context: context,
          builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            'Inserisci la tua email e ti invieremo il link per modificare la password',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          ),

          SizedBox(height: 25),

          //inserimento dell'email
          MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false
          ),

          SizedBox(height: 25),

          MyButton(
            text: 'Reset Password',
            onTap: passwordReset,
          )
          // MaterialButton(onPressed: passwordReset,
          //   child: Text('Reset Password'),
          //   color: Colors.deepPurpleAccent,
          //
          // ),
        ],
      ),
    );
  }
}
