import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('About'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
         leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }
       ),
    ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 500, // Imposta la larghezza dell'immagine
              child: Image.asset('lib/images/clashtitolo.jpg'),
            ),
            SizedBox(height: 25), // Spazio tra l'immagine e il testo
            Text(
              'Progetto di Programmazione Mobile fatto da: \nGabriel Piercecchi \nTosca Pierro \nLorenzo Zulli \nGrazie alle APIs di Clash of Clans', // Inserisci il testo desiderato qui
              style: TextStyle(
                fontSize: 20, // Imposta la dimensione del testo
              ),
            ),
          ],
        ),
      ),
    );
  }
}