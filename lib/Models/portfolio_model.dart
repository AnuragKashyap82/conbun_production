class PortfolioModel {
  final String id;
  final String filetype;
  final String fileUrl;

  PortfolioModel({
    required this.id,
    required this.filetype,
    required this.fileUrl,
  });

  // Factory method to create an instance from a JSON Map
  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(
      id: json['id'] as String,
      filetype: json['filetype'] as String,
      fileUrl: json['file'] as String,
    );
  }
  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'filetype': filetype,
      'file': fileUrl, // Use 'file' here to match the original JSON structure
    };
  }
}
