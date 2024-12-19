import 'dart:convert';
import 'package:conbun_production/Models/transaction_account_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class TransactionAccountRepository extends GetxController {
  static TransactionAccountRepository get instance => Get.find();

  Future<List<TransactionAccountModel>> getAllTransactionAccount(String userId, String type, String limit) async {
    try {
      final requestBody = {"userid": userId, "start": "0", "limit": limit, "type": type};
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/wallet/getUserTransactions'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print('Response status code: ${response.statusCode}');
      print('Response status code getAllTransactionAccount: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> transactionAccountData = json.decode(response.body)['balance'];
        final List<TransactionAccountModel> transactionAccount = transactionAccountData
            .map((transactionAccountJson) => TransactionAccountModel.fromJson(transactionAccountJson))
            .toList();
        print('Response status code: ${transactionAccount}');
        return transactionAccount;
      } else {
        throw "Failed to load transactionAccount Json: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}

