import 'dart:convert';
import 'package:conbun_production/Models/policy_model.dart';
import 'package:conbun_production/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';


class PolicyRepository extends GetxController {
  static PolicyRepository get instance => Get.find();
  RxBool isLoading = false.obs;

  Future<PolicyModel> fetchPolicy(String policy) async {
    isLoading.value = false;

    final requestBody = {
      "policy": policy
    };
    final String requestBodyJson = jsonEncode(requestBody);
    final headers = <String, String>{};
    headers['authtoken'] = Constant.authToken;

    final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/policies/getpolicy'),
        headers: headers,
        body: requestBodyJson
    );

    if (response.statusCode == 200) {
      isLoading.value = false;
      final policyData = json.decode(response.body)['data'];
      print("policy: ${policyData}");
      return PolicyModel.fromJson(policyData);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
