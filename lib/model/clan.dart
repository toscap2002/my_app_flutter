import 'badgeUrls.dart';


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

  Map<String, dynamic> toJson() {
    return {
      'badgeUrls': badgeUrls != null ? badgeUrls.toJson() : null,
      'clanLevel': clanLevel,
      'name': name,
      'tag': tag,
    };
  }

  factory Clan.fromJson(Map<String, dynamic> json) {
    return Clan(
      tag: json['tag'] ?? '',
      name: json['name'] ?? '',
      clanLevel: json['clanLevel'] ?? 0,
      badgeUrls: BadgeUrls.fromJson(json['badgeUrls'] ?? {}),
    );
  }
}
