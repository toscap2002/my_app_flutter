class BadgeUrls {
  final String large;
  final String medium;
  final String small;

  BadgeUrls({
    required this.large,
    required this.medium,
    required this.small,
  });

  Map<String, dynamic> toJson() {
    return {
      'large': large,
      'medium': medium,
      'small': small,
    };
  }

  factory BadgeUrls.fromJson(Map<String, dynamic> json) {
    //print('Creating BadgeUrls from JSON: $json');
    return BadgeUrls(
      large: json['large'] ?? '',
      medium: json['medium'] ?? '',
      small: json['small'] ?? '',
    );
  }
}
