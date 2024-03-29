import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/view/chatPage.dart';
import 'package:my_app_flutter/view/profilePage.dart';
import 'package:my_app_flutter/view/searchPage.dart';
import 'package:http/http.dart' as http;

import 'package:my_app_flutter/view-model/components/rowInfo.dart';
import '../model/player.dart';

class PlayerStatistics extends StatefulWidget {
  final String userID;// L'ID dell'utente
  final String namePS;
  final String userTag;

  PlayerStatistics({super.key, required this.userID, required this.namePS, required this.userTag});

  @override
  State<PlayerStatistics> createState() => _PlayerStatisticsState();
}

class _PlayerStatisticsState extends State<PlayerStatistics> {

  late Future<Player> _playerStatistics;

  Future<Player> fetchPlayerStatistics(String playerTag) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      final firstUrl = 'https://api.clashofclans.com/v1/players/';

      if (user != null) {
        DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference();
        String uid = user.uid;

        // Allo stesso modo, ottieni il DatabaseEvent per apiKey
        DatabaseEvent apiKeyEvent = await databaseReference
            .child('user')
            .child(uid)
            .child('apiKey')
            .once();

        if (apiKeyEvent.snapshot.value != null) {
          String finalTag = playerTag.replaceAll("#", "%23");
          var apiKey = apiKeyEvent.snapshot.value.toString();

          final finalUri = firstUrl + finalTag;

          final response = await http.get(
            Uri.parse(finalUri),
            headers: {'authorization': 'Bearer $apiKey'},
          );

          if (response.statusCode == 200) {
            final jsonData = json.decode(response.body);
            if (jsonData != null && jsonData is Map<String, dynamic>) {
              final player = Player.fromJson(jsonData);
              print(player.toJson());
              return player;
            } else {
              throw Exception('Invalid JSON data');
            }
          } else {
            print('API request failed with status code: ${response.statusCode}');
            throw Exception('Failed to load player statistics${response.statusCode}');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred while fetching player statistics\n'
                'Check your Api Key.\n'
                'If the error persist it must be the Player\'TAG')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred while fetching player statistics\n'
              'Check your Api Key.\n'
              'If the error persist it must be the Player\'TAG')),
        );
      }
    } catch (e) {
      print('Error during fetching player statistics: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while fetching player statistics\n'
            'Check your Api Key.\n'
            'If the error persist it must be the Player\'TAG')),
      );
      throw Exception('An error occurred while fetching player statistics\n'
          'Check your Api Key.\n'
          'If the error persist it must be the Player\'TAG');
    }
    throw Exception('An error occurred while fetching player statistics\n'
        'Check your Api Key.\n'
        'If the error persist it must be the Player\'TAG');
  }

  @override
  void initState() {
    super.initState();
    _playerStatistics = fetchPlayerStatistics(widget.userTag);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Statistiche di ${widget.namePS}'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: FutureBuilder<Player>(
        future: _playerStatistics,
        builder: (context, snapshot) {
          print('Snapshot connection state: ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print('Snapshot error: ${snapshot.error}');
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            final playerData = snapshot.data as Player;
            if (playerData == null) {
              return Center(
                child: Text('No data available'),
              );
            };
            final playerJson = playerData; // Qui crei un oggetto Player dal Map
            final jsonString = JsonEncoder.withIndent('  ').convert(playerJson);
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Informazione di ${playerData.name}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.grey.shade300,
                            Colors.blueGrey.shade400,
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //RowInfo(label: 'Name:', value: playerData.name),
                          RowInfo(label: 'Role:', value: playerData.role ?? 'N/A'),
                          RowInfo(label: 'Tag:', value: playerData.tag ?? 'N/A'),
                          RowInfo(label: 'Best Trophies:', value: playerData.bestTrophies?.toString() ?? 'N/A'),
                          RowInfo(label: 'Best Versus Trophies:', value: playerData.bestVersusTrophies?.toString() ?? 'N/A'),
                          RowInfo(label: 'Builder Hall Level:', value: playerData.builderHallLevel?.toString() ?? 'N/A'),
                          RowInfo(label: 'Donations:', value: playerData.donations?.toString() ?? 'N/A'),
                          RowInfo(label: 'Donations Received:', value: playerData.donationsReceived?.toString() ?? 'N/A'),
                          RowInfo(label: 'Exp Level:', value: playerData.expLevel?.toString() ?? 'N/A'),
                          RowInfo(label: 'Town Hall Level:', value: playerData.townHallLevel?.toString() ?? 'N/A'),
                          RowInfo(label: 'Trophies:', value: playerData.trophies?.toString() ?? 'N/A'),
                          RowInfo(label: 'Versus Trophies:', value: playerData.versusTrophies?.toString() ?? 'N/A'),
                          RowInfo(label: 'War Stars:', value: playerData.warStars?.toString() ?? 'N/A'),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.grey.shade300,
                            Colors.blueGrey.shade400,
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'CLAN',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          RowInfo(label: 'Clan Name:', value: playerData.clan?.name ?? 'N/A'),
                          RowInfo(label: 'Clan Tag:', value: playerData.clan?.tag ?? 'N/A'),
                          RowInfo(label: 'Clan ClanLevel:', value: playerData.clan?.clanLevel?.toString() ?? 'N/A'),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10), // Spazio tra l'etichetta e l'immagine
                              Center(
                                child: playerData.clan?.badgeUrls?.small != null
                                    ? Image.network(playerData.clan!.badgeUrls!.small)
                                    : Text('No badge image available'),
                              ),
                            ],
                          ),
                          //RowInfo(label: 'Large:', value: playerData.clan!.badgeUrls!.large),
                          //Image.network(playerData.clan?.badgeUrls?.large ?? ''),
                          //RowInfo(label: 'Medium:', value: playerData.clan!.badgeUrls!.medium),
                          //Image.network(playerData.clan?.badgeUrls?.medium ?? ''),
                          //RowInfo(label: 'Small:', value: playerData.clan!.badgeUrls!.small),
                        ],
                      ),
                    ),


                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blueGrey.shade100,
                            Colors.blueGrey.shade400,
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [Text(
                              'LABEL ',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            ],
                          ),
                          Column (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: playerData.labels!.map((label) {
                              return  Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.cyan.shade800,
                                      Colors.blueGrey.shade400,
                                    ],
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Text('Label Name:', style: TextStyle(fontWeight: FontWeight.bold)),
                                    RowInfo(label: 'Name:', value: label.name ?? 'N/A'),
                                    SizedBox(height: 10),
                                    Center(
                                      child: label.iconUrls?.small != null
                                          ? Image.network(label.iconUrls!.small)
                                          : Text('No label icon available'),                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.grey.shade300,
                            Colors.blueGrey.shade400,
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RowInfo(label: 'LEAGUE NAME:', value: playerData.league?.name ?? 'N/A'),

                          SizedBox(width: 10), // Spazio tra l'etichetta e l'immagine
                          Center(
                            child: playerData.league?.iconUrls?.small != null
                                ? Image.network(playerData.league!.iconUrls!.small)
                                : Text('No league icon available'),                          ),
                        ],
                      ),
                      // Text('League IconUrlsx:', style: TextStyle(fontWeight: FontWeight.bold)),
                      // RowInfo(label: 'Medium:', value: playerData.league!.iconUrlsx.medium),
                      // RowInfo(label: 'Small:', value: playerData.league!.iconUrlsx.small),
                      // RowInfo(label: 'Tiny:', value: playerData.league!.iconUrlsx.tiny),
                      // Image.network(playerData.league?.iconUrlsx?.medium ?? ''),
                      // Image.network(playerData.league?.iconUrlsx?.small ?? ''),
                      // Image.network(playerData.league?.iconUrls?.tiny ?? ''),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(userId: widget.userID, name: widget.namePS), // Passa l'ID dell'utente
            ),
          );
        },
        child: Icon(Icons.message),

      ),
    );
  }
}