import 'dart:convert';
import 'package:conbun_production/Models/consultants_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../utils/constant.dart';

class ConsultantsDetailsRepository extends GetxController {
  static ConsultantsDetailsRepository get instance => Get.find();
  RxBool isLoading = false.obs;

  Future<ConsultantsDetailsModel> fetchConsultantDetails(String consultantId, String userId) async {
    try {
      print(consultantId);
      final requestBody = {
        "consultantid": consultantId,
        "userid": userId
      };
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/consultants/getConsultantDetails'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);

        print(userData);

        isLoading.value = false;
        return ConsultantsDetailsModel.fromJson(userData);

      } else {
        return ConsultantsDetailsModel.empty();
        throw "Failed to load featuredConsultants Json: ${response.body}";
      }
    } catch (e) {
      return ConsultantsDetailsModel.empty();
      throw "Something went wrong: $e";
    }
  }

}
