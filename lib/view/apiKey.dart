import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/view-model/components/logo.dart';
import 'package:my_app_flutter/view-model/components/textfield.dart';
import 'package:my_app_flutter/view-model/authPage.dart';
import 'package:my_app_flutter/view-model/introPage.dart';

import 'homePage.dart';

class ApiKeyPage extends StatefulWidget {

  @override
  State<ApiKeyPage> createState() => _ApiKeyPageState();
}

class _ApiKeyPageState extends State<ApiKeyPage> {
  final TextEditingController apiKeyController = TextEditingController();

  void _saveApiKeyToFirebase() async {
    String apiKey = apiKeyController.text;
    var user = FirebaseAuth.instance.currentUser;

    if (user != null && apiKey.isNotEmpty) {
      DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();
      String uid = user.uid;

      await databaseReference
          .child('user')
          .child(uid)
          .child('apiKey')
          .set(apiKey)
          .then((_) async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Api Key salvata nel database')),
        );

        DatabaseEvent tagEvent = await databaseReference
            .child('user')
            .child(uid)
            .child('tag')
            .once();

        if (tagEvent.snapshot.value != null) {
          var rawTag = tagEvent.snapshot.value.toString();

          // Naviga verso HomePage solo se il salvataggio ha successo
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AuthPage(), // Passa il valore corretto di playerTag
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('E\' andato storto qualcosa nel recupero dell\'Api Key')),
          );
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore durante il salvataggio dell\' Api Key')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('La chiave non deve essere vuota')),
      );
    }
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
                    'Inserisci nello spazio sottostante l\'api key!\nRicorda di usare l\'indirizzo IP del tuo telefono \n(Per conoscere l\'IP del tuo smartphonevai su whatsmyip)',
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


