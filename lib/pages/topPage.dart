import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app_flutter/model/player.dart';


class TopPage extends StatefulWidget {
  TopPage({super.key});


  @override
  State<TopPage> createState() => _TopPageState();
}

List<Player> player = [];


Future getTopPlayer() async{
  var response = await http.get(Uri.https('https://api.clashofclans.com/v1/players/%232rypjyy'));
  print(response.body);
  var jsonData = jsonDecode(response.body);

  for(var eachPlayer in jsonData['clan']){
    final player = Player(
      bestTrophies: eachPlayer['bestTrophies'],
      bestVersusTrophies: eachPlayer['bestVersusTrophies'],
      builderHallLevel: jsonData['builderHallLevel'],
      clan: jsonData['clan'],
      donations: jsonData['donations'],
      donationsReceived: jsonData['donationsReceived'],
      expLevel: jsonData['expLevel'],
      labels: [],
      league: jsonData[''], // Assicurati di fornire la chiave corretta
      name: '', // Assicurati di fornire la chiave corretta
      role: '', // Assicurati di fornire la chiave corretta
      townHallLevel: jsonData['townHallLevel'],
      trophies: jsonData['trophies'],
      versusTrophies: jsonData['versusTrophies'],
      warStars: jsonData['warStars'],
      tag: '',

    );

  }
  print(player.length);
}


class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    getTopPlayer();
    return Scaffold(
      //La top 50
      //backgroundColor: Colors.grey.shade600,
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
                itemCount: player.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(player[index].bestVersusTrophies as String),
                    subtitle: Text(player[index].bestTrophies as String),
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
