class IconUrls {
  // Puoi definire le proprietà per le URL degli iconUrls

  final String medium;
  final String small;

  IconUrls({
    required this.medium,
    required this.small,
  });

  factory IconUrls.fromJson(Map<String, dynamic> json) {
    return IconUrls(
      medium: json['medium'] ?? '',
      small: json['small'] ?? '',
    );
  }

}
