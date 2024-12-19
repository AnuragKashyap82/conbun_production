
class PackageDurationModel {
  String id;
  String duration;
  String amount;

  PackageDurationModel({
    required this.id,
    required this.duration,
    required this.amount,
  });

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'duration': duration,
      'amount': amount,
    };
  }

  // Factory method to create an instance from a JSON Map
  factory PackageDurationModel.fromJson(Map<String, dynamic> json) {
    return PackageDurationModel(
      id: json['id'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      amount: json['amount'] as String? ?? '',
    );
  }
}
