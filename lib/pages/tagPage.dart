import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../components/logo.dart';

class TagPage extends StatefulWidget {
  const TagPage({super.key});

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  final TextEditingController tagController = TextEditingController();
  String userTag = ""; // Variabile per memorizzare il tag dell'utente

  @override
  void initState() {
    super.initState();
    // Carica il tag dell'utente corrente al momento dell'inizializzazione dello stato
    loadUserTag();
  }

  void loadUserTag() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
      String uid = user.uid;

      DataSnapshot snapshot = (await databaseReference.child('user').child(uid).child('tag').once()) as DataSnapshot;
      if (snapshot.value != null) {
        setState(() {
          userTag = snapshot.value.toString();
        });
      }
    }
  }

  void _saveTagToFirebase() async {
    String tag = tagController.text;
    var user = FirebaseAuth.instance.currentUser;

    if (user != null && tag.isNotEmpty) {
      DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();
      String uid = user.uid;

      await databaseReference
          .child('user')
          .child(uid)
          .child('tag')
          .set(tag)
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('TAG salvato nel database')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore durante il salvataggio del TAG')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Il TAG non deve essere vuoto')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INSERIRE TAG'),
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
                    'Inserisci il tuo Tag, lo troverai nel tuo profilo di Clash of Clans',
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
                        controller: tagController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.black87),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 5, color: Colors.orange),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 5, color: Colors.amber),
                          ),
                          fillColor: Colors.white38,
                          filled: false,
                          hintText: "Il tuo TAG attuale è: $userTag",
                        ),
                      ),

                      SizedBox(height: 16),

                      ElevatedButton(
                        onPressed: () {
                          _saveTagToFirebase();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple[400], // Colore di sfondo del pulsante
                          onPrimary: Colors.white, // Colore del testo del pulsante
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Bordo arrotondato
                          ),
                          padding: const EdgeInsets.all(25),
                        ),
                        child: Text('Salva Tag', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
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
