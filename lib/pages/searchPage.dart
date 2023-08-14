import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/pages/chatPage.dart';
import '../components/textfield.dart';
import 'homePage.dart';
import 'introPage.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            alignment: Alignment.centerRight,
          ),
        ],
        //backgroundColor: Colors.pinkAccent,
        title: MyTextField(
          controller: _searchController,
          hintText: 'Cerca gli utenti',
          obscureText: false,
        ),
      ),
      body: FutureBuilder(
        future: _getUserList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Errore: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('Nessun utente trovato.');
          } else {
            List<UserData> userList = snapshot.data as List<UserData>;
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return _buildUserListItem(userList[index]);
              },
            );
          }
        },
      ),
    );
  }

  Future<List<UserData>> _getUserList() async {
    DatabaseEvent event = await _database.child('user').once();

    if (!event.snapshot.exists || event.snapshot.value == null) {
      return [];
    }

    dynamic snapshotValue = event.snapshot.value;

    if (snapshotValue is Map) {
      Map<dynamic, dynamic> usersMap = Map.from(snapshotValue);

      List<UserData> userList = [];

      usersMap.forEach((userId, userData) {
        if (userData is Map && _auth.currentUser!.uid != userId) {
          userList.add(UserData(
            userId: userId,
            email: userData['email'] ?? '',
            name: userData['name'] ?? '',
          ));
        }
      });

      return userList;
    } else {
      return [];
    }
  }




  Widget _buildUserListItem(UserData userData) {
    return ListTile(
      title: Text(userData.name),
      subtitle: Text(userData.email),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPage(), // Sostituisci con il nome della tua homepage
          ),
        );
      },
    );
  }
}

class UserData {
  final String userId;
  final String name;
  final String email;

  UserData({
    required this.userId,
    required this.name,
    required this.email,
  });
}
