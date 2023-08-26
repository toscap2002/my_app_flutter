import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/drawer.dart';
import 'package:my_app_flutter/model/player.dart';
import 'package:my_app_flutter/pages/about.dart';
import 'package:my_app_flutter/pages/apiService.dart';
import 'package:my_app_flutter/pages/profilePage.dart';
import 'package:my_app_flutter/pages/topPage.dart';
import 'package:my_app_flutter/util/constats.dart';
import 'package:provider/provider.dart';
import 'package:my_app_flutter/pages/authService.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import 'homeAdapter.dart';

class HomePage extends StatefulWidget {
  final String playerTag;
  HomePage({required this.playerTag, Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> _jsonData;

  late Future<Player> _playerStatistics;

  Future<Map<String, dynamic>> fetchPlayerStatistics(String playerTag) async {
    try {
      const String API_KEY =
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6ImMxNDUyYmZiLTNiYWMtNGE4MS05ODhkLTkyODUxMmRmZmNiMCIsImlhdCI6MTY5Mjk3OTQ4Nywic3ViIjoiZGV2ZWxvcGVyLzI1MjUyOTRkLWRjNWQtYTcwOS0zYTVhLTg4Njc3YWQ5M2E1ZiIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjM3LjE2MC4yMzAuMjM2Il0sInR5cGUiOiJjbGllbnQifV19.ULAYZ2F_6JcYMG5mVO1i0-UNqTFqSWoK5A0p42XeCAc5nrfYpx_E35JQCrn1ie7batNU1yc1b4Q2bfLvNSLnqg';
      final correctUrl = 'https://api.clashofclans.com/v1/players/%23gov80r9qc';
      final response = await http.get(
        Uri.parse(correctUrl),
        headers: {'authorization': 'Bearer $API_KEY'},
      );

      if (response.statusCode == 200) {
        // final jsonData = json.decode(response.body);
        // if (jsonData != null && jsonData is Map<String, dynamic>){
        // final player = Player.fromJson(jsonData);
        // return player;
        final jsonData = json.decode(response.body);
        return jsonData;
       //return print('JSON Response: $jsonData');
       //  } else {
       //    throw Exception('Invalid JSON data');
       //  }
      } else {
        throw Exception('Failed to load player statistics${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while fetching player statistics');
    }

  }

  //Metodo di logout
  void logoutUser() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.logoutUser();
  }

  void goToProfilePage() {
    //pop menu drawer
    Navigator.pop(context);
    //go to profile page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

  void goToAboutPage() {
    //pop menu drawer
    Navigator.pop(context);
    //go to about page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AboutPage(),
      ),
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _playerStatistics = fetchPlayerStatistics(widget.playerTag);
  // }

  // Player parsePlayer(Map<String, dynamic> jsonData) {
  //   return Player.fromJson(jsonData);
  // }
  //
  // Future<Player> fetchClashOfClansData(String playertag) async {
  //   const String API_KEY = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjRjOGIxZjVhLTExZjQtNDZkZi1hZDEyLTkyMmNkOThjNGYzYiIsImlhdCI6MTY5Mjk2NjQ1NCwic3ViIjoiZGV2ZWxvcGVyLzI1MjUyOTRkLWRjNWQtYTcwOS0zYTVhLTg4Njc3YWQ5M2E1ZiIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjM3LjE2MS4yMTUuMjQ0Il0sInR5cGUiOiJjbGllbnQifV19.yW4Mdgmezc_0gOw3O3U2UqSsAYTbOeu2fpCIbWS3eM61K3r4Fro8TRnQ4bCWTmW66m44J_AQ5uFyKDVea4ILdA'; // Sostituisci con la tua API key
  //   final correctUrl = 'https://api.clashofclans.com/v1/players/$playertag}';
  //
  //   final response = await http.get(
  //     Uri.parse(correctUrl),
  //     headers: {'authorization': 'Bearer $API_KEY'},
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     return jsonData;
  //   } else {
  //     throw Exception('Failed to fetch data from Clash of Clans API: ${response
  //         .statusCode}');
  //   }
  // }

// Utilizzo del metodo
//   fetchData() async {
//     try {
//       final playerTag = '%23gov80r9qc'; // Sostituisci con il tag del giocatore desiderato
//       final jsonData = await fetchPlayerStatistics(playerTag);
//       print('JSON Data: $jsonData');
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

  @override
  void initState() {
    super.initState();
    _jsonData =  fetchPlayerStatistics(widget.playerTag);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      drawer: MyDrawer(
        onAbout: goToAboutPage,
        onProfile: goToProfilePage,
        onLogout: logoutUser,
      ),
      // body: Center(
      // child: ElevatedButton(
      //   onPressed: fetchData, // Richiama il metodo fetchData al clic del pulsante
      //   child: Text('Fetch and Print JSON'),
      // ),
      // ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _jsonData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            final jsonData = snapshot.data;
            if (jsonData == null) {
              return Center(
                child: Text('No data available'),
              );
            }
            final jsonString = JsonEncoder.withIndent('  ').convert(jsonData);
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(jsonString),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}




      // body: FutureBuilder<Player>(
      //     future: _playerStatistics,
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         if (snapshot.hasError) {
      //           return Center(
      //             child: Text('Error: ${snapshot.error}'),
      //           );
      //         }
      //         final player = snapshot.data;
      //         if (player == null) {
      //           return Center(
      //             child: Text('Player data is null'),
      //           );
      //         }
      //         // Converti il JSON in una stringa e visualizzalo in un widget Text
      //         final playerJson = player.toJson();
      //         final jsonString = jsonEncode(playerJson);
      //         return SingleChildScrollView(
      //           child: Padding(
      //             padding: EdgeInsets.all(16.0),
      //             child: Text(jsonString, style: TextStyle(fontSize: 12)),
      //           ),
      //         );
      //       } else {
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //     }


//       body:  Future<Player>(
//         future: _playerStatistics, // Utilizza la variabile contenente il JSON
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             }
//             final jsonData = snapshot.data;
//             if (jsonData == null) {
//               return Center(
//                 child: Text('No data available'),
//               );
//             }
//             // Converti il JSON in una stringa e visualizzalo in un widget Text
//             final jsonString = jsonEncode(jsonData);
//             return SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(jsonString, style: TextStyle(fontSize: 12)),
//               ),
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }



//    ),
//  );
// }
//}