class CountryModel {
  final String id;
  final String name;
  final String phonecode;
  final String iso3;
  final String emoji;

  CountryModel({
    required this.id,
    required this.name,
    required this.phonecode,
    required this.iso3,
    required this.emoji,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phonecode: json['phonecode'] as String,
      iso3: json['iso3'] as String,
      emoji: json['emoji'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phonecode': phonecode,
      'iso3': iso3,
      'emoji': emoji,
    };
  }
}
