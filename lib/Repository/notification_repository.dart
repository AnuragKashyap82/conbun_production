import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Models/notification_model.dart';
import '../utils/constant.dart';

class NotificationRepository extends GetxController {
  static NotificationRepository get instance => Get.find();

  Future<List<NotificationModel>> getAllNotification(String userId) async {
    try {
      final requestBody = {"userid": userId, "type": "User"};
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/notifications/get'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print('Response status code: ${response.statusCode}');
      print('Response status code getAllLeads: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> leadData = json.decode(response.body)['data'];
        final List<NotificationModel> allLead = leadData
            .map((leadJson) => NotificationModel.fromJson(leadJson))
            .toList();
        print('Response status code: ${allLead}');
        return allLead;
      } else {
        throw "Failed to load allLead Json: ${response.body}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}

