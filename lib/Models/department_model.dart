class DepartmentModel {
  final String departmentId;
  final String name;

  DepartmentModel({
    required this.departmentId,
    required this.name,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      departmentId: json['departmentid'] as String,
      name: json['name'] as String,
    );
  }
}
