import 'dart:convert';
import 'package:conbun_production/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../Models/user_model.dart';


class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  RxBool isLoading = false.obs;

  Future<UserModel> fetchUserData(String userId) async {
    isLoading.value = false;

    final requestBody = {
      "userid": userId
    };
    final String requestBodyJson = jsonEncode(requestBody);
    final headers = <String, String>{};
    headers['authtoken'] = Constant.authToken;

    final response = await http.post(
      Uri.parse('${Constant.baseUrl}api/users/getUserDetails'),
      headers: headers,
      body: requestBodyJson
    );

    if (response.statusCode == 200) {
      isLoading.value = false;
      final userData = json.decode(response.body)['data'];
      print(userData);
      print("SSSSSSSSSSSSSSSSSSSS ${userData}");
      return UserModel.fromJson(userData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> fetchUserWalletBalance(String userId) async {
    isLoading.value = false;

    final requestBody = {
      "userid": userId
    };
    final String requestBodyJson = jsonEncode(requestBody);
    final headers = <String, String>{};
    headers['authtoken'] = Constant.authToken;

    final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/wallet/getUserWalletBalance'),
        headers: headers,
        body: requestBodyJson
    );

    if (response.statusCode == 200) {
      isLoading.value = false;
      final userData = json.decode(response.body);
      print(userData);
      return userData;
    } else {
      throw Exception('Failed to load data');
    }
  }

}
