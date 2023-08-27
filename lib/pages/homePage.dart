import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/drawer.dart';
import 'package:my_app_flutter/model/player.dart';
import 'package:my_app_flutter/pages/about.dart';
import 'package:my_app_flutter/pages/profilePage.dart';
import 'package:my_app_flutter/pages/topPage.dart';
import 'package:my_app_flutter/util/constats.dart';
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
  //late Future<Map<String, dynamic>> _jsonData;

  late Future<Player> _playerStatistics;

  Future<Player> fetchPlayerStatistics(String playerTag) async {
    try {
      print('Fetching player statistics...');
      const String API_KEY =
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjVhNjBkMjMyLTM4NjctNDdjZS04ZThlLTJlN2ZhZjAxMTVjMCIsImlhdCI6MTY5MzExNDgxNiwic3ViIjoiZGV2ZWxvcGVyLzI1MjUyOTRkLWRjNWQtYTcwOS0zYTVhLTg4Njc3YWQ5M2E1ZiIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjM3LjE2My45Ni4zOCJdLCJ0eXBlIjoiY2xpZW50In1dfQ.IzPWIS66pOzYNd2DDNF6snx2R-sS3BrujCLwwsFTWt0v0gSaB_sv-G0uBb637VyCPKKVPoMaiNAgGLUmvdh37Q';
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
                //child: Text(jsonString),
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text('Name: ${playerData.name}'),
                //     Text('Role: ${playerData.role}'),
                //     Text('Tag: ${playerData.tag}'),
                //     Text('Best Trophies: ${playerData.bestTrophies.toString()}'),
                //     Text('Best Versus Trophies: ${playerData.bestVersusTrophies.toString()}'),
                //     Text('Builder Hall Level: ${playerData.builderHallLevel.toString()}'),
                //     Text('Donations: ${playerData.donations.toString()}'),
                //     Text('Donations Received: ${playerData.donationsReceived.toString()}'),
                //     Text('Exp Level: ${playerData.expLevel.toString()}'),
                //     Text('Town Hall Level: ${playerData.townHallLevel.toString()}'),
                //     Text('Trophies: ${playerData.trophies.toString()}'),
                //     Text('Versus Trophies: ${playerData.versusTrophies.toString()}'),
                //     Text('War Stars: ${playerData.warStars.toString()}'),
                //     Text('Clan Name: ${playerData.clan?.name}'),
                //     Text('Clan Tag: ${playerData.clan?.tag}'),
                //     Text('Clan ClanLevel: ${playerData.clan?.clanLevel}'),
                //     Text('Clan BadgeUrls - Large: ${playerData.clan?.badgeUrls?.large}'),
                //     Text('Clan BadgeUrls - Medium: ${playerData.clan?.badgeUrls?.medium}'),
                //     Text('Clan BadgeUrls - Small: ${playerData.clan?.badgeUrls?.small}'),
                //     Text('Label Names:'),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: playerData.labels!.map((label) {
                //         return Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text('Label Name: ${label.name}'),
                //             Text('Label ID: ${label.id}'),
                //             Text('Label IconUrls - Medium: ${label.iconUrls.medium}'),
                //             Text('Label IconUrls - Small: ${label.iconUrls.small}'),
                //             // Aggiungi altri attributi dell'oggetto Label qui
                //       ],
                //     );
                //   }).toList(),
                // ),
                //
                //       Text('League Name: ${playerData.league?.name}'),
                //       Text('League ID: ${playerData.league?.id}'),
                //       Text('League IconUrlsx - Medium: ${playerData.league?.iconUrlsx?.medium}'),
                //       Text('League IconUrlsx - Small: ${playerData.league?.iconUrlsx?.small}'),
                //       Text('League IconUrlsx - Tiny: ${playerData.league?.iconUrlsx?.tiny}'),
                //   ],
                // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Player Information:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      RowInfo(label: 'Name:', value: playerData.name),
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
                      SizedBox(height: 20),
                      Text('Clan Information:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      RowInfo(label: 'Clan Name:', value: playerData.clan!.name),
                      RowInfo(label: 'Clan Tag:', value: playerData.clan!.tag),
                      RowInfo(label: 'Clan ClanLevel:', value: playerData.clan!.clanLevel.toString()),
                      SizedBox(height: 10),
                      Text('Clan BadgeUrls:', style: TextStyle(fontWeight: FontWeight.bold)),
                      //RowInfo(label: 'Large:', value: playerData.clan!.badgeUrls!.large),
                      //Image.network(playerData.clan?.badgeUrls?.large ?? ''),
                      //RowInfo(label: 'Medium:', value: playerData.clan!.badgeUrls!.medium),
                      //Image.network(playerData.clan?.badgeUrls?.medium ?? ''),
                      //RowInfo(label: 'Small:', value: playerData.clan!.badgeUrls!.small),
                      Image.network(playerData.clan?.badgeUrls?.small ?? ''),
                      SizedBox(height: 20),
                      Text('Label Information:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: playerData.labels!.map((label) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Label Name:', style: TextStyle(fontWeight: FontWeight.bold)),
                              RowInfo(label: 'Name:', value: label.name),
                              RowInfo(label: 'ID:', value: label.id.toString()),
                              SizedBox(height: 10),
                              Text('Label IconUrls:', style: TextStyle(fontWeight: FontWeight.bold)),
                              //RowInfo(label: 'Medium:', value: label.iconUrls.medium),
                              //Image.network(label.iconUrls.medium ?? ''),
                              //RowInfo(label: 'Small:', value: label.iconUrls.small),
                              Image.network(label.iconUrls.small ?? ''),
                              // Aggiungi altri attributi dell'oggetto Label qui
                            ],
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20),
                      Text('League Information:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      if (playerData.league != null) ...[
                        RowInfo(label: 'League Name:', value: playerData.league!.name),
                        RowInfo(label: 'League ID:', value: playerData.league!.id.toString()),
                        Text('League IconUrlsx:', style: TextStyle(fontWeight: FontWeight.bold)),
                        // RowInfo(label: 'Medium:', value: playerData.league!.iconUrlsx.medium),
                        // RowInfo(label: 'Small:', value: playerData.league!.iconUrlsx.small),
                        // RowInfo(label: 'Tiny:', value: playerData.league!.iconUrlsx.tiny),
                        // Image.network(playerData.league?.iconUrlsx?.medium ?? ''),
                        // Image.network(playerData.league?.iconUrlsx?.small ?? ''),
                        Image.network(playerData.league?.iconUrlsx?.tiny ?? ''),

                      ],
                    ],
                  )

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

class RowInfo extends StatelessWidget {
  final String label;
  final String value;

  RowInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150, // Larghezza fissa per l'etichetta
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }
}
