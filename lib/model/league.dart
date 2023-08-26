import 'package:my_app_flutter/model/iconUrls.dart';

import 'iconUrlsX.dart';

class League {
  final IconUrlsX iconUrlsx;
  final int id;
  final String name;

  League({
    required this.iconUrlsx,
    required this.id,
    required this.name,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      name: json['name'],
      iconUrlsx: IconUrlsX.fromJson(json['iconUrlsx']),
      // ... altre proprietà
    );
  }
}