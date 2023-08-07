import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/textfield.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
  }

class _SearchPageState extends State<SearchPage> {

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          IconButton(
            onPressed: () {
            Navigator.pop(context);
          },
            icon: Icon(Icons.arrow_back),
          ),
        ],
        backgroundColor: Colors.pinkAccent,
        title: MyTextField(
          controller: searchController,
          hintText: 'Cerca gli amici',
          obscureText: false,
        ),
      ),
      body: ListView.builder(itemBuilder: (context, index){
        return Row(children: [
          CircleAvatar(child:
            Icon(Icons.food_bank),
          ),
          SizedBox(width: 20
          ),
          Text(
            'data',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
            ),
          ),
        ],
        );
      },
      ),
    );
  }
}
