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

  Map<String, dynamic> toJson() {
    return {
      'iconUrlsx': iconUrlsx != null ? iconUrlsx.toJson() : null,
      'id': id,
      'name': name,
    };
  }

  factory League.fromJson(Map<String, dynamic> json) {
    //print('Creating League from JSON: $json');
    return League(
      id: json['id'],
      name: json['name'],
      iconUrlsx: IconUrlsX.fromJson(json['iconUrlsx']),
    );
  }
}