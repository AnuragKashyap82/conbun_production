class UserModel {
  String deviceId;
  String deviceToken;
  String id;
  String? name;
  String? email;
  String phoneNumber;
  String? gender;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? address;
  String referralCode;
  String profileImage;

  UserModel({
    required this.deviceId,
    required this.deviceToken,
    required this.id,
    required this.name,
    this.email,
    required this.phoneNumber,
    this.gender,
    this.city,
    required this.state,
    required this.country,
    this.pincode,
    this.address,
    required this.referralCode,
    required this.profileImage,
  });

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'deviceid': deviceId,
      'devicetoken': deviceToken,
      'id': id,
      'name': name,
      'email': email,
      'phonenumber': phoneNumber,
      'gender': gender,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
      'address': address,
      'referral_code': referralCode,
      'profile_image': profileImage,
    };
  }

  // Factory method to create an instance from a JSON Map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      deviceId: json['deviceid'] ?? '',
      deviceToken: json['devicetoken'] ?? '',
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'],
      phoneNumber: json['phonenumber'] ?? '',
      gender: json['gender'],
      city: json['city'],
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      pincode: json['pincode'],
      address: json['address'],
      referralCode: json['referral_code'] ?? '',
      profileImage: json['profile_image'] ?? '',
    );
  }

  // Method to create an empty UserModel instance
  factory UserModel.empty() {
    return UserModel(
      deviceId: '',
      deviceToken: '',
      id: '',
      name: '',
      email: '',
      phoneNumber: '',
      gender: '',
      city: '',
      state: '',
      country: '',
      pincode: '',
      address: '',
      referralCode: '',
      profileImage: '',
    );
  }
}
