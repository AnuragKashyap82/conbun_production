

class TransactionRechargeModel {
  String id;
  String amount;
  String paymentMode;
  String paymentMethod;
  String dateRecorded;
  String status;
  String transactionId;

  TransactionRechargeModel({
    required this.id,
    required this.amount,
    required this.paymentMode,
    required this.paymentMethod,
    required this.dateRecorded,
    required this.status,
    required this.transactionId,
  });

  factory TransactionRechargeModel.fromJson(Map<String, dynamic> json) {
    return TransactionRechargeModel(
      id: json['id'] as String? ?? '',
      amount: json['amount'] as String? ?? '',
      paymentMode: json['paymentmode'] as String? ?? '',
      paymentMethod: json['paymentmethod'] as String? ?? '',
      dateRecorded: json['daterecorded'] as String? ?? '',
      status: json['status'] as String? ?? '',
      transactionId: json['transactionid'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount.toString(),
      'paymentmode': paymentMode,
      'paymentmethod': paymentMethod,
      'daterecorded': dateRecorded,
      'status': status,
      'transactionid': transactionId,
    };
  }
}
