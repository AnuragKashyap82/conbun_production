class ServiceAreaModel {
  final String id;
  final String name;
  final String latitude;
  final String longitude;

  ServiceAreaModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  // Factory method to create an instance from a JSON Map
  factory ServiceAreaModel.fromJson(Map<String, dynamic> json) {
    return ServiceAreaModel(
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
    );
  }

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Factory method to create an empty ServiceAreaModel instance
  factory ServiceAreaModel.empty() {
    return ServiceAreaModel(
      id: '',
      name: '',
      latitude: '',
      longitude: '',
    );
  }
}
