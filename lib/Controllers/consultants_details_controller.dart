
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:conbun_production/Repository/consultants_details_repository.dart';
import 'package:get/get.dart';

import '../Models/consultants_details_model.dart';
import '../utils/constant.dart';


class ConsultantDetailsController extends GetxController {
  Rx<ConsultantsDetailsModel> userData = ConsultantsDetailsModel.empty().obs;
  static ConsultantDetailsController get instance => Get.find();
  RxString reportReason = 'I don’t want to tell'.obs;
  RxString responseMessage = ''.obs;
  final isLoading = false.obs;
  final _consultantDetailsRepository = Get.put(ConsultantsDetailsRepository());

  Future<void> fetchUserData(String consultantId, String userId) async {
    try {
      isLoading.value = true;
      final data = await _consultantDetailsRepository.fetchConsultantDetails(consultantId, userId);
      isLoading.value = false;
      userData.value = data;
    } catch (e) {
      print(e.toString());
      isLoading.value = false;
    }
  }

  Future reportSpam(
      String consultantId,
      String userId,
      String reportReason,
      String reportComment,
      ) async {
    isLoading.value = true;
    final requestBody = {
      "consultantid": consultantId,
      "userid": userId,
      "report_reason": reportReason,
      "comment": reportComment,
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/spamreport/submitReport'),
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
