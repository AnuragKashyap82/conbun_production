class CouponModel {
  String id;
  String couponCode;
  String couponTitle;
  String description;

  CouponModel({
    required this.id,
    required this.couponCode,
    required this.couponTitle,
    required this.description,
  });

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coupon_code': couponCode,
      'coupon_title': couponTitle,
      'description': description,
    };
  }

  // Factory method to create an instance from a JSON Map
  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'] as String? ?? '',
      couponCode: json['coupon_code'] as String? ?? '',
      couponTitle: json['coupon_title'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }
}
