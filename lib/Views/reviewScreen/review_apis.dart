import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../utils/constant.dart';

class ReviewApis extends GetxController {
  RxBool isLoading = false.obs;

  Future writeReview(
      String userId,
      String consultantId,
      String rating,
      String review,
      ) async {
    isLoading.value = true;
    final requestBody = {
      'userid': userId,
      'consultantid': consultantId,
      'rating': rating,
      'review': review,
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/conbun_production/writeReview'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      print(consultantId);
      print(userId);
      print(responseBody);
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


}
