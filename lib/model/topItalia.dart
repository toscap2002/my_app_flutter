class TopItalia {
  final List<TopPlayer> items;

  TopItalia({
    required this.items,
  });

  factory TopItalia.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rawItems = json['items'] ?? [];
    final items = rawItems.map((rawItem) => TopPlayer.fromJson(rawItem)).toList();

    return TopItalia(
      items: items,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iteams': items,
    };
  }

}

class TopPlayer {
  final String name;
  final String tag;

  TopPlayer({
    required this.name,
    required this.tag,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tag': tag,
    };
  }

  factory TopPlayer.fromJson(Map<String, dynamic> json) {
    final name = json['name'] ?? "Nome non disponibile";
    final tag = json['tag'] ?? "Tag non disponibile";

    return TopPlayer(
      name: name,
      tag: tag,
    );
  }
}
