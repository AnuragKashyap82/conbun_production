class ServiceCategoryModel {
  String id;
  String name;
  String displayOrder;
  String thumbnail;

  ServiceCategoryModel({
    required this.id,
    required this.name,
    required this.displayOrder,
    required this.thumbnail,
  });

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'display_order': displayOrder,
      'thumbnail': thumbnail,
    };
  }

  // Factory method to create an instance from a JSON Map
  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    return ServiceCategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      displayOrder: json['display_order'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}
