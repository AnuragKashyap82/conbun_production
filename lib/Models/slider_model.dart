class SliderModel {
  String id;
  String title;
  String description;
  String link;
  String order;
  String image;

  SliderModel({
    required this.id,
    required this.title,
    required this.description,
    required this.link,
    required this.order,
    required this.image,
  });

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'link': link,
      'order': order,
      'image': image,
    };
  }

  // Factory method to create an instance from a JSON Map
  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      link: json['link'] ?? '',
      order: json['order'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
