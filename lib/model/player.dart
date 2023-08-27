
import 'package:my_app_flutter/model/clan.dart';

import 'label.dart';
import 'league.dart';

class Player {
  final int bestTrophies;
  final int bestVersusTrophies;
  final int builderHallLevel;
  final Clan? clan;
  final int donations;
  final int donationsReceived;
  final int expLevel;
  final List<Label>? labels;
  final League? league;
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
      this.clan,
    required this.donations,
    required this.donationsReceived,
    required this.expLevel,
      this.labels,
      this.league,
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
      'clan': clan?.toJson(), // Serializza l'oggetto Clan in una mappa JSON
      'donations': donations,
      'donationsReceived': donationsReceived,
      'expLevel': expLevel,
      'labels': labels?.map((label) => label.toJson()).toList(), // Serializza la lista di Label in una lista di mappe JSON
      'league': league?.toJson(), // Serializza l'oggetto League in una mappa JSON
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
    //print('Creating Player from JSON: $json');

    final bestTrophies = json['bestTrophies'] ?? 0;
    final bestVersusTrophies = json['bestVersusTrophies'] ?? 0;
    final builderHallLevel = json['builderHallLevel'] ?? 0;
    final clanJson = json['clan'];
    final donations = json['donations'] ?? 0;
    final donationsReceived = json['donationsReceived'] ?? 0;
    final expLevel = json['expLevel'] ?? 0;
    final labelsJson = json['labels'];
    final leagueJson = json['league'];
    final name = json['name'] ?? '';
    final role = json['role'] ?? '';
    final tag = json['tag'] ?? '';
    final townHallLevel = json['townHallLevel'] ?? 0;
    final trophies = json['trophies'] ?? 0;
    final versusTrophies = json['versusTrophies'] ?? 0;
    final warStars = json['warStars'] ?? 0;

    //Clan? clan = clanJson != null ? Clan.fromJson(clanJson) : null;
    Clan? clan;
    if (clanJson != null && clanJson is Map<String, dynamic>) {
      clan = Clan.fromJson(clanJson);
    }

    League? league;
    if (leagueJson != null && leagueJson is Map<String, dynamic>) {
      league = League.fromJson(leagueJson);
    }


    List<Label> labels = [];
    if (labelsJson != null) {
      labels = List<Label>.from(labelsJson.map((labelJson) => Label.fromJson(labelJson)));
    }

    return Player(
      bestTrophies: bestTrophies,
      bestVersusTrophies: bestVersusTrophies,
      builderHallLevel: builderHallLevel,
      clan: clan,
      donations: donations,
      donationsReceived: donationsReceived,
      expLevel: expLevel,
      labels: labels,
      league: league,
      name: name,
      role: role,
      tag: tag,
      townHallLevel: townHallLevel,
      trophies: trophies,
      versusTrophies: versusTrophies,
      warStars: warStars,
    );
  }
}

// class Players {
//   final List<Player> players;
//
//   Players({required this.players});
// }


