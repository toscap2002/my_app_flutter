import 'dart:convert';

import 'iconUrlsX.dart';


class League {
  final IconUrlsX iconUrls;
  final int id;
  final String name;

  League({
    required this.iconUrls,
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {
      'iconUrls': iconUrls != null ? iconUrls.toJson() : null,
      'id': id,
      'name': name,
    };
    print(jsonEncode(data)); // Stampa la stringa JSON
    return data;
  }

  factory League.fromJson(Map<String, dynamic> json) {
    print('Creating League from JSON: $json');
    return League(
      id: json['id'],
      name: json['name'],
      iconUrls: IconUrlsX.fromJson(json['iconUrls']),
    );
  }
}