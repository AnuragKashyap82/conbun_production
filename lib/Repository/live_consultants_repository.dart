import 'dart:convert';
import 'package:conbun_production/Models/live_consultant_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class LiveConsultantsRepository extends GetxController {
  static LiveConsultantsRepository get instance => Get.find();

  Future<List<LiveConsultantModel>> getLiveConsultants(String userId) async {
    try {
      final requestBody = {"userid": userId, "start": "0", "limit": "1000"};
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/livecall/getLiveConsultants'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> liveConsultantsData = json.decode(response.body);
        final List<LiveConsultantModel> liveConsultants = liveConsultantsData
            .map((liveConsultantsJson) =>
            LiveConsultantModel.fromJson(liveConsultantsJson))
            .toList();
        print('Response status code: ${liveConsultants}');
        return liveConsultants;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
