import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/textfield.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
  }

class _SearchPageState extends State<SearchPage> {

  final searchController = TextEditingController();

  void updateList(String value){
    //questa è la funzione che filtrerà la nostra lista
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.grey.shade800,
       body: Padding(
         padding: EdgeInsets.all(16),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
               'Cerca un altro giocatore',
               style: TextStyle(
                   color: Colors.black45,
                   fontSize: 22,
                 fontWeight: FontWeight.bold,
               ),
             ),
           SizedBox(
             height: 20,
           ),
             TextField(
               style: TextStyle(color: Colors.black45),
               decoration: InputDecoration(
                 filled: true,
                 fillColor: Colors.grey,
                   enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(width: 5, color: Colors.amberAccent.shade400),
                   borderRadius: BorderRadius.circular(50.0),
                 ),
                 focusedBorder: OutlineInputBorder(
                   borderSide: BorderSide(width: 5, color: Colors.amber.shade300),
                   borderRadius: BorderRadius.circular(50.0),
                 ),
                 hintText: 'Cerca...',
                 prefixIcon: Icon(Icons.search),
                 prefixIconColor: Colors.amber,
               ),
             ),
             SizedBox(height:  20,
             ),
             Expanded(child: ListView(),
             ),
           ],
         ),
       ),
    );
  }
}
