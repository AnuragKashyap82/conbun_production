class TransactionAccountModel {
  String id;
  String userId;
  String relId;
  String relType;
  String amount;
  String type;
  String narration;
  String dateCreated;
  String status;

  TransactionAccountModel({
    required this.id,
    required this.userId,
    required this.relId,
    required this.relType,
    required this.amount,
    required this.type,
    required this.narration,
    required this.dateCreated,
    required this.status,
  });

  factory TransactionAccountModel.fromJson(Map<String, dynamic> json) {
    return TransactionAccountModel(
      id: json['id'] ?? '',
      userId: json['userid'] ?? '',
      relId: json['rel_id'] ?? '',
      relType: json['rel_type'] ?? '',
      amount: json['amount'] ?? '',
      type: json['type'] ?? '',
      narration: json['narration'] ?? '',
      dateCreated: json['datecreated'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userid': userId,
      'rel_id': relId,
      'rel_type': relType,
      'amount': amount,
      'type': type,
      'narration': narration,
      'datecreated': dateCreated,
      'status': status,
    };
  }
}
