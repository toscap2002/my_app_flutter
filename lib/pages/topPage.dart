import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app_flutter/model/topItalia.dart';
import 'package:my_app_flutter/pages/topStatistic.dart';

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
          throw Exception('API key not found in database');
        }
      } else {
        throw Exception('User not logged in');
      }
    } catch (e) {
      print('Error getting API key from database: $e');
      throw Exception('Error getting API key from database');
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
        print('API request failed with status code: ${response.statusCode}');
        throw Exception('Failed to load player statistics${response.statusCode}');
      }
    } catch (e) {
      print('Error during fetching top Italia data: $e');
      throw Exception('An error occurred while fetching top Italia data: $e');
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
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text('No data available'),
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


