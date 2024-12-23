import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;

import '../../utils/constant.dart';

class LoginApis extends GetxController {
  RxBool isLoading = false.obs;
  RxString deviceToken = ''.obs;
  RxString deviceId = 'an'.obs;

  Future sendOTP(String mobile, String referralcode, String deviceid, String devicetoken) async {
    isLoading.value = true;

    final requestBody = {
      'mobile': mobile,
      'referralcode': referralcode,
      'deviceid': deviceid,
      'devicetoken': devicetoken,
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/auth/sendOTP'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      Map<String, dynamic> responseBody = json.decode(response.body);

      print("clicked!!!");

      if (response.statusCode == 200) {
        isLoading.value = false;
        // Check if the status is true
        return responseBody;
      } else {
        isLoading.value = false;
        return responseBody;
      }
    } catch (e) {
      isLoading.value = false;
      isLoading.value = false;
      return "An error occurred: $e";
    }
  }
}