import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _search = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? userMap;
  bool isLoading = false;


  void onUserTapped() {
    // Qui puoi fare qualcosa quando l'utente clicca su un risultato
  }

  void onSearch() async {
    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('user')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        setState(() {
          userMap = value.docs[0].data();
          isLoading = true;
        });
      } else {
        setState(() {
          userMap = null;
          isLoading = false;
        });
      }
      print(userMap);
    });
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text("Cerca un giocatore"),
      ),
      backgroundColor:Colors.grey.shade600,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size.height / 20,
            ),
            Container(
              height: size.height / 14,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 14,
                width: size.width / 1.15,
                child: TextField(
                  controller: _search,
                  decoration: InputDecoration(
                    hintText: "Cerca...",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 5, color: Colors.pinkAccent),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 5, color: Colors.pink.shade300),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 50,
            ),
            isLoading
                ? Container(
              height: size.height / 12,
              width: size.height / 12,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
                : ElevatedButton(
              onPressed: onSearch,
              child: Text("Cerca"),
              style: ElevatedButton.styleFrom(
                primary: Colors.pinkAccent,
              ),
            ),
            userMap != null
                ? ListTile(
              //onTap: onUserTapped,
             // leading: Icon(Icons.account_box),
              title: Text(userMap!['email']),
              subtitle: Text(userMap!['email']),
             // trailing: Icon(Icons.add),
            )

          //     : ListTile(
          // title: Text("Utente non trovato")
            //),
            :Container(),
          ],
        ),
      ),
    );
  }
}