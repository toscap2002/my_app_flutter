import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/drawer.dart';
import 'package:my_app_flutter/components/rowInfo.dart';
import 'package:my_app_flutter/model/player.dart';
import 'package:my_app_flutter/pages/about.dart';
import 'package:my_app_flutter/pages/apiKey.dart';
import 'package:my_app_flutter/pages/profilePage.dart';
import 'package:my_app_flutter/pages/tagPage.dart';
import 'package:my_app_flutter/pages/topPage.dart';
import 'package:my_app_flutter/pages/tutorialPage.dart';
import 'package:provider/provider.dart';
import 'package:my_app_flutter/pages/authService.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';


class HomePage extends StatefulWidget {
  final String playerTag;
  HomePage({required this.playerTag, Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Player> _playerStatistics;

  Future<Player> fetchPlayerStatistics(String playerTag) async {
    try {
      print('Fetching player statistics...');
      const String API_KEY =
'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6ImFhYTQxNjcwLTVjZjctNGNjMy05YmViLTU3MTk1ZGQ3MWZhZiIsImlhdCI6MTY5MzEzODc2MSwic3ViIjoiZGV2ZWxvcGVyLzI1MjUyOTRkLWRjNWQtYTcwOS0zYTVhLTg4Njc3YWQ5M2E1ZiIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjIuMzguMTM0LjEzIl0sInR5cGUiOiJjbGllbnQifV19.aLgAvAQ8OJ9kVWziVF_e53h9zRsbAa4YwvV22yK-LRYAXNOp4vQd5YZDxMdOw8qRNWScqS1j1KRMM6l3XHdHEw';
      final correctUrl = 'https://api.clashofclans.com/v1/players/%23gov80r9qc';
      final response = await http.get(
        Uri.parse(correctUrl),
        headers: {'authorization': 'Bearer $API_KEY'},
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
    } catch (e) {
      print('Error during fetching player statistics: $e');
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

  void goToTutorialPage() {
    //pop menu drawer
    Navigator.pop(context);
    //go to about page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TutorialPage(),
      ),
    );
  }

  void goToApiKeyPage() {
    //pop menu drawer
    Navigator.pop(context);
    //go to about page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApiKeyPage(),
      ),
    );
  }

  void goToTagPage() {
    //pop menu drawer
    Navigator.pop(context);
    //go to about page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TagPage(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _playerStatistics =  fetchPlayerStatistics(widget.playerTag);
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
        onTutorial: goToTutorialPage,
        onApiKey: goToApiKeyPage,
        onTagPage: goToTagPage,
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
                            RowInfo(label: 'Role:', value: playerData.role),
                            RowInfo(label: 'Tag:', value: playerData.tag),
                            RowInfo(label: 'Best Trophies:', value: playerData.bestTrophies.toString()),
                            RowInfo(label: 'Best Versus Trophies:', value: playerData.bestVersusTrophies.toString()),
                            RowInfo(label: 'Builder Hall Level:', value: playerData.builderHallLevel.toString()),
                            RowInfo(label: 'Donations:', value: playerData.donations.toString()),
                            RowInfo(label: 'Donations Received:', value: playerData.donationsReceived.toString()),
                            RowInfo(label: 'Exp Level:', value: playerData.expLevel.toString()),
                            RowInfo(label: 'Town Hall Level:', value: playerData.townHallLevel.toString()),
                            RowInfo(label: 'Trophies:', value: playerData.trophies.toString()),
                            RowInfo(label: 'Versus Trophies:', value: playerData.versusTrophies.toString()),
                            RowInfo(label: 'War Stars:', value: playerData.warStars.toString()),
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
                                RowInfo(label: 'Clan Name:', value: playerData.clan!.name),
                                RowInfo(label: 'Clan Tag:', value: playerData.clan!.tag),
                                RowInfo(label: 'Clan ClanLevel:', value: playerData.clan!.clanLevel.toString()),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10), // Spazio tra l'etichetta e l'immagine
                                  Center(
                                    child: Image.network(playerData.clan?.badgeUrls?.small ?? ''),
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
                                  RowInfo(label: 'Name:', value: label.name),
                                    SizedBox(height: 10),
                                    Center(
                                      child: Image.network(label.iconUrls.small ?? ''),
                                    ),
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
                              RowInfo(label: 'LEAGUE NAME:', value: playerData.league!.name),

                              SizedBox(width: 10), // Spazio tra l'etichetta e l'immagine
                              Center(
                               child: Image.network(playerData.league?.iconUrls?.small ?? ''),
                              ),
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
    );
  }
}

