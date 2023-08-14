import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/pages/chatPage.dart';
import '../components/textfield.dart';

class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.search),
            alignment: Alignment.centerRight,
          ),
       ],
        //backgroundColor: Colors.pinkAccent,
        title: MyTextField(
          controller: _searchController,
          hintText: 'Cerca gli amici',
          obscureText: false,
        ),
      ),
      body: _buildUserList(),

      );

    }

    //creare la lista degli utenti senza l'utente loggato
    Widget _buildUserList() {
      // Esegui la query diretta per verificare il numero di documenti nella raccolta "user"
      FirebaseFirestore.instance.collection('user').get().then((querySnapshot) {
        print("Numero di documenti: ${querySnapshot.size}");
      });

      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('user').snapshots(),
          builder: (context, snapshot) {

            if (snapshot.hasError) {
              return Text('Errore: ${snapshot.error}');
            }

            if (!snapshot.hasData) {
              return Text('Nessun dato disponibile.');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text('Nessun utente trovato.');
            }
            snapshot.data!.docs.forEach((doc) {
              print("Documento: ${doc.id}");
              print("Dati: ${doc.data()}");
            });
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                return ListTile(
                  title: Text(data['email']), // Assicurati che 'email' corrisponda alla chiave nei tuoi documenti
                  subtitle: Text(data['uid']), // Assicurati che 'uid' corrisponda alla chiave nei tuoi documenti
                );
              },
            );
                  print("StreamBuilder - Snapshot ConnectionState: ${snapshot.connectionState}");
                  if (snapshot.hasError){
                    print("StreamBuilder - Error: ${snapshot.error}");
                    return const Text('ERRORE');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting){
                    print("StreamBuilder - No data found.");
                    return const Text('loading...');
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Text('Nessun utente trovato.');
                  }
                  return ListView(
                    children: snapshot.data!.docs
                        .map<Widget>((doc) => _buildUserListItem(doc))
                        .toList(),
                  );
                }
            );
          }




      //creare la lista dei singli elementi dell'utente
      Widget _buildUserListItem(DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

      //mostra tutti gli utenti senza quello corrente
      if (_auth.currentUser!.uid != data['uid']){
        return ListTile(
          title: Text(data['email']),
          onTap: (){
            //passa l'uid dell'utente cliccato per la pagine della chat
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
              receiveUserEmail: data['email'],
              receiverUserID: data['uid'],
            ),
            ),
            );
            },
          );
        }else {
          //ritorna il contenitore vuoto
          return Container();
        }
      }

      // void onSearch(String query) {
      //   final suggestion = user.where((user){
      //    final input = query.toLowerCase();
      //    return email.contains(input);
      //   }).toList();
    }

