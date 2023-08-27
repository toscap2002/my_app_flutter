class IconUrls {
  // Puoi definire le proprietà per le URL degli iconUrls

  final String medium;
  final String small;

  IconUrls({
    required this.medium,
    required this.small,
  });

  Map<String, dynamic> toJson() {
    return {
      'medium': medium,
      'small': small,
    };
  }

  factory IconUrls.fromJson(Map<String, dynamic> json) {
    //print('Creating IconUrls from JSON: $json');
    return IconUrls(
      medium: json['medium'] ?? '',
      small: json['small'] ?? '',
    );
  }

}
