import 'dart:convert';
import 'package:conbun_production/Models/transaction_recharge_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class TransactionRechargeRepository extends GetxController {
  static TransactionRechargeRepository get instance => Get.find();

  Future<List<TransactionRechargeModel>> getAllTransactionRecharge(String userId, String status, String limit) async {
    try {
      final requestBody = {"userid": userId, "start": "0", "limit": limit, "status": status};
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/wallet/getUserRechargeTransactions'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print('Response status code: ${response.statusCode}');
      print('Response status code getAllTransactionRecharge: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> transactionRechargeData = json.decode(response.body)['balance'];
        final List<TransactionRechargeModel> transactionRecharge = transactionRechargeData
            .map((transactionAccountJson) => TransactionRechargeModel.fromJson(transactionAccountJson))
            .toList();
        print('Response status code: ${transactionRecharge}');
        return transactionRecharge;
      } else {
        throw "Failed to load getAllTransactionRecharge Json: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}

