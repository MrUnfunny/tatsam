class Country {
  final String name;
  final String region;
  bool favorite;

  String? short;
  Country({
    required this.name,
    required this.region,
    this.short,
    this.favorite = false,
  });

  Country copyWith({
    String? name,
    String? region,
    String? short,
    bool? favorite,
  }) {
    return Country(
      name: name ?? this.name,
      region: region ?? this.region,
      short: short ?? this.short,
      favorite: favorite ?? this.favorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'country': name,
      'region': region,
      'short': short,
      'favorite': favorite,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      name: map['country'] ?? '',
      region: map['region'] ?? '',
      short: map['short'] ?? '',
      favorite: map['favorite'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Country(name: $name, region: $region, favorite: $favorite, short: $short)';
  }
}
