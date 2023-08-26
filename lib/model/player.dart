
import 'package:my_app_flutter/model/clan.dart';

import 'label.dart';
import 'league.dart';

class Player {
  final int bestTrophies;
  final int bestVersusTrophies;
  final int builderHallLevel;
  final Clan clan;
  final int donations;
  final int donationsReceived;
  final int expLevel;
  final List<Label> labels;
  final League league;
  final String name;
  final String role;
  final String tag;
  final int townHallLevel;
  final int trophies;
  final int versusTrophies;
  final int warStars;

  Player({
    required this.bestTrophies,
    required this.bestVersusTrophies,
    required this.builderHallLevel,
    required this.clan,
    required this.donations,
    required this.donationsReceived,
    required this.expLevel,
    required this.labels,
    required this.league,
    required this.name,
    required this.role,
    required this.tag,
    required this.townHallLevel,
    required this.trophies,
    required this.versusTrophies,
    required this.warStars,
  });



// Definisci il metodo toJson che converte l'oggetto Player in una mappa JSON
  Map<String, dynamic> toJson() {
    return {
      'bestTrophies': bestTrophies,
      'bestVersusTrophies': bestVersusTrophies,
      'builderHallLevel': builderHallLevel,
      'clan': clan,
      'donations': donations,
      'donationsReceived': donationsReceived,
      'expLevel': expLevel,
      'labels': labels,
      'league': league,
      'name': name,
      'role': role,
      'tag': tag,
      'townHallLevel': townHallLevel,
      'trophies': trophies,
      'versusTrophies': versusTrophies,
      'warStars': warStars,

      // Aggiungi tutte le altre proprietà dell'oggetto Player qui
    };
  }


  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      bestTrophies: json['bestTrophies'],
      bestVersusTrophies: json['bestVersusTrophies'],
      builderHallLevel: json['builderHallLevel'],
      clan: Clan.fromJson(json['clan']),
      donations: json['donations'],
      donationsReceived: json['donationsReceived'],
      expLevel: json['expLevel'],
      labels: json['labels'] != null
          ? List<Label>.from(json['labels'].map((labelJson) => Label.fromJson(labelJson)))
          : [],
      league: League.fromJson(json['league']),
      name: json['name'],
      role: json['role'],
      tag: json['tag'],
      townHallLevel: json['townHallLevel'],
      trophies: json['trophies'],
      versusTrophies: json['versusTrophies'],
      warStars: json['warStars'],
    );
  }

}

class Players {
  final List<Player> players;

  Players({required this.players});
}


