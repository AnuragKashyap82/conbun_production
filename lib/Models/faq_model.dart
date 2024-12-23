
class FaqModel {
  String id;
  String title;
  String description;

  FaqModel({
    required this.id,
    required this.title,
    required this.description,
  });

  // Factory method to create an instance from a JSON Map
  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? ''
    );
  }

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
  // Method to create an empty UserModel instance
  factory FaqModel.empty() {
    return FaqModel(
      id: '',
      title: '',
      description: '',
    );
  }
}
