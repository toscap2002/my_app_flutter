class IconUrlsX {
  final String medium;
  final String small;
  final String tiny;

  IconUrlsX({
    required this.medium,
    required this.small,
    required this.tiny,
  });

  Map<String, dynamic> toJson() {
    return {
      'medium': medium,
      'small': small,
      'tiny': tiny,
    };
  }

  factory IconUrlsX.fromJson(Map<String, dynamic> json) {
    //print('Creating IconUrlsx from JSON: $json');
    return IconUrlsX(
      tiny: json['tiny'] ?? '',
      medium: json['medium'] ?? '',
      small: json['small'] ?? '',
    );
  }
}