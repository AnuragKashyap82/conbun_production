class LiveConsultantModel {
  String id;
  String name;
  String verified;
  String featured;
  String experience;
  String city;
  String state;
  String profileImage;
  String avgRating;
  String reviews;
  String categories;
  String serviceArea;
  String devicetoken; // Optional field

  LiveConsultantModel({
    required this.id,
    required this.name,
    required this.verified,
    required this.featured,
    required this.experience,
    required this.city,
    required this.state,
    required this.profileImage,
    required this.avgRating,
    required this.reviews,
    required this.categories,
    required this.serviceArea,
    required this.devicetoken,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'verified': verified,
      'featured': featured,
      'experience': experience,
      'city': city,
      'state': state,
      'profile_image': profileImage,
      'avg_rating': avgRating,
      'reviews': reviews,
      'categories': categories,
      'serviceArea': serviceArea,
      'devicetoken': devicetoken,
    };
  }

  factory LiveConsultantModel.fromJson(Map<String, dynamic> json) {
    return LiveConsultantModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      verified: json['verified'] ?? '',
      featured: json['featured'] ?? '',
      experience: json['experience'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      profileImage: json['profile_image'] ?? '',
      avgRating: json['avg_rating'] ?? '',
      reviews: json['reviews'] ?? '',
      categories: json['categories'] ?? '',
      serviceArea: json['serviceArea'] ?? '',
      devicetoken: json['devicetoken'] ?? '',
    );
  }
}
