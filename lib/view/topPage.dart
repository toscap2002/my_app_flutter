import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app_flutter/model/topItalia.dart';
import 'package:my_app_flutter/view/topStatistic.dart';

class TopPage extends StatefulWidget {
  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  late Future<TopItalia> _topItalia;


  Future<String> getApiKey() async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference();
        String uid = user.uid;

        DatabaseEvent apiKeyEvent = await databaseReference
            .child('user')
            .child(uid)
            .child('apiKey')
            .once();

        if (apiKeyEvent.snapshot.value != null) {
          return apiKeyEvent.snapshot.value.toString();
        } else {
          throw Exception('Chiave Api non trovata nel database');
        }
      } else {
        throw Exception('L\'utente non ha eseguito l\'accesso');
      }
    } catch (e) {
      print('Errore dal recupero della chiave dal database: $e');
      throw Exception('Errore dal recupero della chiave dal database');
    }
  }


  Future<TopItalia> fetchTopItalia(String apiKey) async {
    try {
      final firstUrl = 'https://api.clashofclans.com/v1/locations/32000120/rankings/players';
      final response = await http.get(
        Uri.parse(firstUrl),
        headers: {'authorization': 'Bearer $apiKey'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData != null && jsonData is Map<String, dynamic>) {
          final topIt = TopItalia.fromJson(jsonData);
          print(topIt.toJson());
          return topIt;
        } else {
          throw Exception('Invalid JSON data');
        }
      } else {
        print('Richiesta API fallita: ${response.statusCode}');
        throw Exception('Ricarica delle statistiche del giocatore fallita ${response.statusCode}');
      }
    } catch (e) {
      print('Errore durante il recupero della top italia: $e');
      throw Exception('Errore durante il recupero della top italia: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _topItalia = getApiKey().then((apiKey) => fetchTopItalia(apiKey));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Top giocatori italiani'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: FutureBuilder<TopItalia>(
        future: _topItalia,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Errore: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text('Non ci sono dati disponibili'),
            );
          } else {
            final topData = snapshot.data as TopItalia;

            return ListView.builder(
              itemCount: topData.items?.length ?? 0,
              itemBuilder: (context, index) {
                final item = topData.items?[index];
                if (item != null) {
                  final position = index + 1; // Calculate the position
                  return ListTile(
                    title: Text('$position. ${item.name ?? 'N/A'}'),
                    subtitle: Text(item.tag ?? 'N/A'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TopStatistics( userID: '', // Pass the user ID if needed
                        userTag: item.tag, // Pass the user tag
                        namePS: item.name ?? '', // Pass the user name
                         ),
                        ),
                      );
                    },
                  );
                } else {
                  return SizedBox(); // Empty widget if data is missing
                }
              },
            );
          }
        },
      ),
    );
  }
}


