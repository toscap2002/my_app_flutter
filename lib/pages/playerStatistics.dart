import 'package:flutter/material.dart';
import 'package:my_app_flutter/pages/chatPage.dart';
import 'package:my_app_flutter/pages/profilePage.dart';
import 'package:my_app_flutter/pages/searchPage.dart';

class PlayerStatistics extends StatefulWidget {
  final String userID;// L'ID dell'utente
  final String namePS;
  PlayerStatistics({super.key, required this.userID, required this.namePS});

  @override
  State<PlayerStatistics> createState() => _PlayerStatisticsState();
}

class _PlayerStatisticsState extends State<PlayerStatistics> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        title: Text('Statistiche di ${widget.namePS}'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
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