import 'dart:convert';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constant.dart';

class FeedbackApis extends GetxController {
  RxBool isLoading = false.obs;

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id') ?? ''; // Set default value as empty string
    return userId;
  }
  Future submitFeedBack(
    String feedback,
  ) async {
    isLoading.value = true;
    String userId = await getUserId();
    print(userId);
    final requestBody = {
      'rel_id': userId,
      'rel_type': 'User',
      'feedback': feedback,
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/feedback/submitFeedback'),
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
        return responseBody;
      }
    } catch (e) {
      isLoading.value = false;
      return "An error occurred: $e";
    }
  }
}
