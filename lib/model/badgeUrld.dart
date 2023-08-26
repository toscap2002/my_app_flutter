class BadgeUrls {
  final String large;
  final String medium;
  final String small;

  BadgeUrls({
    required this.large,
    required this.medium,
    required this.small,
  });

  factory BadgeUrls.fromJson(Map<String, dynamic> json) {
    return BadgeUrls(
      large: json['large'] ?? '',
      medium: json['medium'] ?? '',
      small: json['small'] ?? '',
    );
  }
}
