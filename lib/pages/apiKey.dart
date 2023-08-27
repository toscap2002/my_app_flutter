import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/logo.dart';
import 'package:my_app_flutter/components/textfield.dart';

class ApiKeyPage extends StatefulWidget {

  @override
  State<ApiKeyPage> createState() => _ApiKeyPageState();
}

class _ApiKeyPageState extends State<ApiKeyPage> {
  final TextEditingController apiKeyController = TextEditingController();

  void _saveApiKeyToFirebase() {
    String apyKey = apiKeyController.text;
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.child('user').child('uid').child('apiKey').set(apyKey).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Api Key salvata nel database')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore durante il salvataggio dell\' Api Key')),
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API KEY'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      backgroundColor: Colors.grey[100],
      body:  SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                //logo
                Logo(),

                SizedBox(height: 25),

                Center(
                  child: Text(
                    'Inserisci nello spazio sottostante l\'api key!\nRicorda di usare l\'indirizzo IP del tuo telefono (Per conoscere l\'IP del tuo smartphonevai su whatsmyip)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        style: TextStyle(color: Colors.black87),
                        controller: apiKeyController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.black87),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 5, color: Colors.orange),
                          ),focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 5, color: Colors.amber),
                        ),
                          fillColor: Colors.white38,
                          filled: true,
                        ),
                      ),

                      SizedBox(height: 16),

                      ElevatedButton(
                        onPressed: () {
                          _saveApiKeyToFirebase();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple[400], // Colore di sfondo del pulsante
                          onPrimary: Colors.white, // Colore del testo del pulsante
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Bordo arrotondato
                          ),
                          padding: const EdgeInsets.all(25),
                        ),
                        child: Text('Salva API KEY', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


