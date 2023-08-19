import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app_flutter/model/village.dart';

class TopPage extends StatefulWidget {
  TopPage({super.key});


  @override
  State<TopPage> createState() => _TopPageState();
}

List<Village> villages = [];


Future getTopPlayer() async{
  var response = await http.get(Uri.https('api'));
  //print(response.body);
  var jsonData = jsonDecode(response.body);

  for(var eachPlayer in jsonData['nome array json']){
    final village = Village(
        jsonObgect1: eachPlayer['jsonObgect1'],
        jsonObgect2: eachPlayer['jsonObgect2'],
    );
    villages.add(village);
  }
  print(villages.length);
}


class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    getTopPlayer();
    return Scaffold(
      //La top 50
      backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        title: Text('Top 50 giocatori'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: FutureBuilder(
        future: getTopPlayer(),
        builder: (context, snapshot){
          //ha caricato? allora mostra i dati
          if(snapshot.connectionState == ConnectionState.done){
            return ListView.builder(
                itemCount: villages.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(villages[index].jsonObgect1),
                    subtitle: Text(villages[index].jsonObgect2),
                  );
                },
            );
          }
          //se sta ancora caricando, mostra il cerchio di caricmento
          else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

        },
      ),
    );


  }
}
