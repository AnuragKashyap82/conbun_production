import 'dart:convert';
import 'package:conbun_production/Models/invite_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constant.dart';

class InviteRepository extends GetxController {
  static InviteRepository get instance => Get.find();

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id') ?? ''; // Set default value as empty string

    return userId;
  }
  Future<ReferralData> getAllInvites() async {
    try {
      String userId = await getToken();
      final requestBody = {
        "userid": userId,
        "start": "0",
        "limit": '100'
      };
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/referrals/get'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken,
        },
        body: jsonEncode(requestBody),
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['Error'] != 0) {
          throw "API Error: ${responseData['message']}";
        }

        final data = responseData['data'];
        return ReferralData.fromJson(data);
      } else {
        throw "Failed to load invites: HTTP ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }

}
