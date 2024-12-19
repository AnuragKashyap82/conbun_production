import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constant.dart';

class VerifyOtpApis extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isVerifyOTPButtonActive = true.obs;
  RxString deviceToken = ''.obs;
  RxString deviceId = ''.obs;

  Future verifyOTP(String mobile, String otp, String deviceid, String devicetoken) async {
    isLoading.value = true;
    isVerifyOTPButtonActive.value = false;
    final requestBody = {
      'mobile': mobile,
      'otp': otp,
      'deviceid': deviceid,
      'devicetoken': devicetoken,
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/auth/verifyOTP'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      Map<String, dynamic> responseBody = json.decode(response.body);

      print("clicked!!!$responseBody");

      if (response.statusCode == 200) {
        isLoading.value = false;
        // Check if the status is true
        if (responseBody['Error'] == 0) {
          String message = responseBody['message'];

          return responseBody;
        } else {
          // Handle the case where status is false or other error conditions
          isLoading.value = false;
          String message = responseBody['message'];
          return responseBody;
        }
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

  Future<void> saveToken(String token)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', token);
  }
}
