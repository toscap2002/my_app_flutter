class IconUrlsX {
  final String medium;
  final String small;
  final String tiny;

  IconUrlsX({
    required this.medium,
    required this.small,
    required this.tiny,
  });

  factory IconUrlsX.fromJson(Map<String, dynamic> json) {
    return IconUrlsX(
      tiny: json['tiny'] ?? '',
      medium: json['medium'] ?? '',
      small: json['small'] ?? '',
    );
  }
}