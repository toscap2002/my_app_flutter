import 'iconUrls.dart';

class Label {
  final IconUrls iconUrls;
  final int id;
  final String name;

  Label({
    required this.iconUrls,
    required this.id,
    required this.name,
  });

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      id: json['id'],
      name: json['name'],
      iconUrls: IconUrls.fromJson(json['iconUrls']),
      // ... altre proprietà
    );
  }
}
