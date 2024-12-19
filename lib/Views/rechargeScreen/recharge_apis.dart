import 'dart:convert';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../utils/constant.dart';

class RechargeApis extends GetxController {
  RxBool isLoading = false.obs;

  RxString couponId = ''.obs;
  RxString couponAmount = ''.obs;
  RxString couponCode = ''.obs;
  RxString couponTitle = ''.obs;
  RxString couponDescription = ''.obs;
  RxString netAmount = ''.obs;

  Future rechargeUserWallet(
    String userId,
    String couponId,
    String couponAmount,
    String amount,
    String netAmount,
    String transactionId,
    String paymentMode,
    String paymentMethod,
    String status,
  ) async {
    isLoading.value = true;
    final requestBody = {
      'userid': userId,
      'couponid': couponId,
      'couponamount': couponAmount,
      'amount': amount,
      'netamount': netAmount,
      'transactionid': transactionId,
      'paymentmode': paymentMode,
      'paymentmethod': paymentMethod,
      'status': status,
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/wallet/rechargeUserWallet'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      Map<String, dynamic> responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;
        return responseBody;
      } else {
        isLoading.value = false;
        isLoading.value = false;
        return responseBody;
      }
    } catch (e) {
      isLoading.value = false;
      isLoading.value = false;
      return "An error occurred: $e";
    }
  }

  Future applyCoupon(
      String userId,
      String amount,
      String couponCode,
      ) async {
    isLoading.value = true;
    final requestBody = {
      'userid': userId,
      'amount': amount,
      'couponcode': couponCode,
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/coupons/applyCoupon'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      Map<String, dynamic> responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;
        return responseBody;
      } else {
        isLoading.value = false;
        isLoading.value = false;
        return responseBody;
      }
    } catch (e) {
      isLoading.value = false;
      isLoading.value = false;
      return "An error occurred: $e";
    }
  }

  void clearCoupon(){
    couponId.value = '';
    couponAmount.value = '';
    netAmount.value = '';
    couponTitle.value = '';
    couponDescription.value = '';
  }
}
