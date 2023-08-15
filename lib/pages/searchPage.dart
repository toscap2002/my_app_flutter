import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/pages/chatPage.dart';
import '../components/textfield.dart';
import 'homePage.dart';
import 'introPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Importa il pacchetto


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  List<UserData> _filteredUserList = [];
  List<UserData> _fullUserList = [];

  @override
  void initState() {
    super.initState();
    _loadUserList();
  }

  void _loadUserList() async {
    DatabaseEvent event = await _database.child('user').once();

    if (!event.snapshot.exists || event.snapshot.value == null) {
      return;
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

      setState(() {
        _fullUserList = userList;
        _filteredUserList = userList;
      });
    }
  }

  void _filterUsers(String query) {
    setState(() {
      _filteredUserList = _fullUserList.where((user) {
        return user.name.toLowerCase().contains(query.toLowerCase());
      }).toList();

      if (_filteredUserList.isEmpty) {
        Fluttertoast.showToast(
          msg: "Nessun utente trovato",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    });
  }

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
        title: TextField(
          // Utilizza il widget TextField nativo
          style: TextStyle(color: Colors.black87),
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Cerca gli utenti',
            hintStyle: TextStyle(color: Colors.black87),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 5, color: Colors.orange),
              borderRadius: BorderRadius.circular(50.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 5, color: Colors.amber.shade400),
              borderRadius: BorderRadius.circular(50.0),
            ),
            fillColor: Colors.grey,
            filled: true,
          ),
          onChanged: _filterUsers, // Aggiunto onChanged
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredUserList.length,
        itemBuilder: (context, index) {
          return _buildUserListItem(_filteredUserList[index]);
        },
      ),
    );
  }

  Widget _buildUserListItem(UserData userData) {
    return ListTile(
      title: Text(userData.name),
      subtitle: Text(userData.email),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(userId: userData.userId, name: userData.name,), // Passa l'ID dell'utente
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

