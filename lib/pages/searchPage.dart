import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/textfield.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
  }

class _SearchPageState extends State<SearchPage> {
   late Map<String, dynamic> userMap;
   bool isLoading = false;

  // void updateList(String value){
  //   //questa è la funzione che filtrerà la nostra lista
  // }

  TextEditingController searchController = TextEditingController();

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });


    await _firestore
        .collection('users')
        .where("email", isEqualTo: searchController.text)
        .get()
        .then((value) => {
          setState(() {
            userMap = value.docs[0].data();
            isLoading = false;
          },
          ),
      print(userMap),
          },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
              onPressed: onSearch,
              icon: Icon(Icons.search),
            alignment: Alignment.centerRight,
          ),
          IconButton(
            alignment: Alignment.centerLeft,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),

          ),
        ],
        //backgroundColor: Colors.pinkAccent,
        title: MyTextField(
          controller: searchController,
          hintText: 'Cerca gli amici',
          obscureText: false,
        ),
      ),
      );


  }
}
