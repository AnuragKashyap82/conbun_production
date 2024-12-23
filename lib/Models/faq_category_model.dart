
class FaqCategoryModel {
  String id;
  String name;

  FaqCategoryModel({
    required this.id,
    required this.name,
  });

  // Factory method to create an instance from a JSON Map
  factory FaqCategoryModel.fromJson(Map<String, dynamic> json) {
    return FaqCategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? ''
    );
  }

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
  // Method to create an empty UserModel instance
  factory FaqCategoryModel.empty() {
    return FaqCategoryModel(
      id: '',
      name: '',
    );
  }
}
