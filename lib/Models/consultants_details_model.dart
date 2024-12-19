class ConsultantReviewModel {
  String name;
  String rating;
  String review;
  String dateCreated;

  ConsultantReviewModel({
    required this.name,
    required this.rating,
    required this.review,
    required this.dateCreated,
  });

  factory ConsultantReviewModel.fromJson(Map<String, dynamic> json) {
    return ConsultantReviewModel(
      name: json['name'] ?? '',
      rating: json['rating'] ?? '',
      review: json['review'] ?? '',
      dateCreated: json['datecreated'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rating': rating,
      'review': review,
      'datecreated': dateCreated,
    };
  }
}

class ConsultantsDetailsModel {
  String id;
  String name;
  String verified;
  String featured;
  String experience;
  String city;
  String state;
  String country;
  String profileImage;
  String about;
  String workingDayFrom;
  String workingDayTo;
  String workingHoursFrom;
  String workingHoursTo;
  String avgRating;
  String devicetoken;
  String totalAppointments;
  int totalFollowers;
  List<ConsultantReviewModel> reviews;
  String categories;
  String serviceArea;
  bool isFollow;

  ConsultantsDetailsModel({
    required this.id,
    required this.name,
    required this.verified,
    required this.featured,
    required this.experience,
    required this.city,
    required this.state,
    required this.country,
    required this.profileImage,
    required this.about,
    required this.workingDayFrom,
    required this.workingDayTo,
    required this.workingHoursFrom,
    required this.workingHoursTo,
    required this.avgRating,
    required this.devicetoken,
    required this.reviews,
    required this.totalAppointments,
    required this.totalFollowers,
    required this.categories,
    required this.serviceArea,
    required this.isFollow,
  });

  factory ConsultantsDetailsModel.fromJson(Map<String, dynamic> json) {
    var reviewList = json['reviews'] as List<dynamic>?; // Nullable check
    List<ConsultantReviewModel> reviewItems = reviewList != null
        ? reviewList.map((item) => ConsultantReviewModel.fromJson(item)).toList()
        : [];

    return ConsultantsDetailsModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      verified: json['verified'] ?? '',
      featured: json['featured'] ?? '',
      experience: json['experience'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      profileImage: json['profile_image'] ?? '',
      about: json['about'] ?? '',
      workingDayFrom: json['workingday_from'] ?? '',
      workingDayTo: json['workingday_to'] ?? '',
      workingHoursFrom: json['workinghours_from'] ?? '',
      workingHoursTo: json['workinghours_to'] ?? '',
      avgRating: json['avg_rating'] ?? '',
      devicetoken: json['devicetoken'] ?? '',
      totalAppointments: json['totalAppointments'] ?? '',
      totalFollowers: json['totalFollowers'] ?? '',
      reviews: reviewItems,
      categories: json['categories'] ?? '',
      serviceArea: json['serviceArea'] ?? '',
      isFollow: json['is_follow'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'verified': verified,
      'featured': featured,
      'experience': experience,
      'city': city,
      'state': state,
      'country': country,
      'profile_image': profileImage,
      'about': about,
      'workingday_from': workingDayFrom,
      'totalFollowers': totalFollowers,
      'workingday_to': workingDayTo,
      'workinghours_from': workingHoursFrom,
      'workinghours_to': workingHoursTo,
      'avg_rating': avgRating,
      'devicetoken': devicetoken,
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'categories': categories,
      'is_follow': isFollow,
      'serviceArea': serviceArea,

    };
  }

  static ConsultantsDetailsModel empty() {
    return ConsultantsDetailsModel(
      id: '',
      name: '',
      verified: '',
      featured: '',
      experience: '',
      city: '',
      state: '',
      country: '',
      profileImage: '',
      about: '',
      workingDayFrom: '',
      workingDayTo: '',
      workingHoursFrom: '',
      workingHoursTo: '',
      avgRating: '',
      devicetoken: '',
      reviews: [],
      totalAppointments: '',
      totalFollowers: 0,
      categories: '',
      serviceArea: '',
      isFollow: false,
    );
  }
}

