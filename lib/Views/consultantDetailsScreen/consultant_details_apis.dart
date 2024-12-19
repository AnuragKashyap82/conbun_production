import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;

import '../../utils/constant.dart';

class ConsultantDetailsApis extends GetxController {
  RxBool isLoading = false.obs;
  RxString deviceToken = ''.obs;
  RxString deviceId = ''.obs;


  Future followConsultant(String userId, String consultantId) async {
    isLoading.value = true;

    final requestBody = {
      'userid': userId,
      'consultantid': consultantId,
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/consultants/follow'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      Map<String, dynamic> responseBody = json.decode(response.body);


      if (response.statusCode == 200) {
        isLoading.value = false;
        // Check if the status is true
        if (responseBody['Error'] == 0) {

          return responseBody;
        } else {
          // Handle the case where status is false or other error conditions
          isLoading.value = false;
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
}
