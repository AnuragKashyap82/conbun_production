
class PolicyModel {
  String id;
  String name;
  String content;

  PolicyModel({
    required this.id,
    required this.name,
    required this.content,
  });

  // Factory method to create an instance from a JSON Map
  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      content: json['content'] ?? '',
    );
  }

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'content': content,
    };
  }
  // Method to create an empty UserModel instance
  factory PolicyModel.empty() {
    return PolicyModel(
      id: '',
      name: '',
      content: '',
    );
  }
}
