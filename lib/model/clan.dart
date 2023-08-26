import 'badgeUrld.dart';

class Clan {
  final BadgeUrls badgeUrls;
  final int clanLevel;
  final String name;
  final String tag;

  Clan({
    required this.badgeUrls,
    required this.clanLevel,
    required this.name,
    required this.tag,
  });

  factory Clan.fromJson(Map<String, dynamic> json) {
    return Clan(
      tag: json['tag'],
      name: json['name'],
      clanLevel: json['clanLevel'],
      badgeUrls: BadgeUrls.fromJson(json['bagdesUrls']),
      // ... altre proprietà
    );
  }

}