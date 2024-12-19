class PriorityModel {
  final String priorityId;
  final String name;

  PriorityModel({
    required this.priorityId,
    required this.name,
  });

  factory PriorityModel.fromJson(Map<String, dynamic> json) {
    return PriorityModel(
      priorityId: json['priorityid'] as String,
      name: json['name'] as String,
    );
  }
}
