import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../Models/followers_model.dart';
import '../utils/constant.dart';


class FollowerRepository extends GetxController {
  static FollowerRepository get instance => Get.find();
  RxBool isLoading = false.obs;

  Future<List<FollowerModel>> getAllFollowers(String userid) async {
    try {
      final requestBody = {"userid": userid, "start": "0", "limit": "100"};
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/followers/getUserFollowings'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print('Response status code: ${response.statusCode}');
      print(userid);
      print('Response status code getAllLeads: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> followerData = json.decode(response.body)['data'];

        final List<FollowerModel> allFollowers = followerData
            .map((leadJson) => FollowerModel.fromJson(leadJson))
            .toList();

        print('Response status code: ${allFollowers}');
        return allFollowers;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

}
