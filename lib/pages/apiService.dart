// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class PlayerStatistics {
//   final String name;
//   final int trophies;
//   // Altre proprietà che vuoi ottenere dalle statistiche del giocatore
//
//   PlayerStatistics({required this.name, required this.trophies});
// }
//
// class PlayerProfileScreen extends StatefulWidget {
//   final String playerTag; // Inserisci qui il tag del giocatore
//
//   PlayerProfileScreen({required this.playerTag});
//
//   @override
//   _PlayerProfileScreenState createState() => _PlayerProfileScreenState();
// }
//
// class _PlayerProfileScreenState extends State<PlayerProfileScreen> {
//   late Future<PlayerStatistics> playerStats;
//
//   @override
//   void initState() {
//     super.initState();
//     playerStats = fetchPlayerStatistics();
//   }
//
//   // Future<PlayerStatistics> fetchPlayerStatistics() async {
//   //   try{
//   //     final response = await http.get(
//   //       Uri.parse('https://api.clashofclans.com/v1/players/${widget.playerTag}'),
//   //       headers: {'authorization': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjQwODEzOWZlLTA3MzQtNDQ5Mi05ZTBkLTFlN2JjM2ZmZTY5ZCIsImlhdCI6MTY5Mjg4NTMxOCwic3ViIjoiZGV2ZWxvcGVyLzI1MjUyOTRkLWRjNWQtYTcwOS0zYTVhLTg4Njc3YWQ5M2E1ZiIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjIuMzIuMjQ1LjQiXSwidHlwZSI6ImNsaWVudCJ9XX0.SN8vaMudworbbNCg3iJ1oy5zAhHPcFwVI_EGNEFZ8rgk17NIbwk_A33FlbpuzYI1TbsKdaMEYixFtWn8INPLyA'
//   //       }, // Sostituisci con la tua API Key
//   //     );
//   //
//   //     if (response.statusCode == 200) {
//   //       final jsonData = json.decode(response.body);
//   //       return PlayerStatistics(
//   //         name: jsonData['name'],
//   //         trophies: jsonData['trophies'],
//   //         // Estrarre altre proprietà necessarie
//   //       );
//   //     } else {
//   //       throw Exception('Failed to load player statistics');
//   //     }
//   //   }catch (e) {
//   //     print('Error during HTTP request: $e');
//   //     print(e.toString());
//   //   }
//   //
//   // }
//   Future<PlayerStatistics> fetchPlayerStatistics(String playerTag) async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://api.clashofclans.com/v1/players/$playerTag'),
//         headers: {'authorization': 'Bearer YOUR_API_KEY'}, // Sostituisci con la tua API Key
//       );
//
//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         return PlayerStatistics(
//           name: jsonData['name'],
//           trophies: jsonData['trophies'],
//           // Estrarre altre proprietà necessarie
//         );
//       } else {
//         throw Exception('Failed to load player statistics');
//       }
//     } catch (e) {
//       print('Error during HTTP request: $e');
//       print(e.toString());
//       rethrow; // Rilancia l'eccezione per gestirla più in alto
//     }
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: FutureBuilder<PlayerStatistics>(
//         future: playerStats,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Player Name: ${snapshot.data!.name}'),
//                   Text('Trophies: ${snapshot.data!.trophies}'),
//                   // Mostra altre statistiche
//                 ],
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }
//           return CircularProgressIndicator(); // In attesa dei dati
//         },
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:my_app_flutter/model/player.dart';

import 'homePage.dart';


