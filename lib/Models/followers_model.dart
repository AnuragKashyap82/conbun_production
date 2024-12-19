class FollowerModel {
  final String id;
  final String consultantid;
  final String hash;
  final String verified;
  final String experience;
  final String city;
  final String state;
  final String consultant_name;
  final String profileImage;
  final String avgRating;
  final String reviews;
  final String categories;

  FollowerModel({
    required this.id,
    required this.consultantid,
    required this.hash,
    required this.verified,
    required this.experience,
    required this.city,
    required this.state,
    required this.consultant_name,
    required this.profileImage,
    required this.avgRating,
    required this.reviews,
    required this.categories,
  });

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'consultantid': consultantid,
      'hash': hash,
      'verified': verified,
      'experience': experience,
      'city': city,
      'state': state,
      'consultant_name': consultant_name,
      'profile_image': profileImage,
      'avg_rating': avgRating,
      'reviews': reviews,
      'categories': categories,
    };
  }

  // Factory method to create an instance from a JSON Map
  factory FollowerModel.fromJson(Map<String, dynamic> json) {
    return FollowerModel(
      id: json['id'] ?? '',
      consultantid: json['consultantid'] ?? '',
      hash: json['hash'] ?? '',
      verified: json['verified'] ?? '',
      experience: json['experience'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      consultant_name: json['consultant_name'] ?? '',
      profileImage: json['profile_image'] ?? '',
      avgRating: json['avg_rating'] ?? '',
      reviews: json['reviews'] ?? '',
      categories: json['categories'] ?? '',
    );
  }

  // Method to create an empty FollowerModel instance
  factory FollowerModel.empty() {
    return FollowerModel(
      id: '',
      consultantid: '',
      hash: '',
      verified: '',
      experience: '',
      city: '',
      state: '',
      consultant_name: '',
      profileImage: '',
      avgRating: '',
      reviews: '',
      categories: '',
    );
  }
}
