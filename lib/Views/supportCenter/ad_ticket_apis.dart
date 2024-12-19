import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constant.dart';

class AddTicketApis extends GetxController {
  RxBool isLoading = false.obs;
  RxString priorityId = ''.obs;
  RxString departmentId = ''.obs;

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id') ?? ''; // Set default value as empty string
    return userId;
  }

  Future addTicket(String subject, String department, String message, String priority) async {

    String userId = await getToken();
    final requestBody = {
      "subject": subject,
      "department": department,
      "rel_type": 'User',
      "userid": userId,
      "message": message,
      "priority": priority,
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/tickets/data'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      Map<String, dynamic> responseBody = json.decode(response.body);


      if (response.statusCode == 200) {

        // Check if the status is true
        return responseBody;
      } else {

        return responseBody;
      }
    } catch (e) {
      return "An error occurred: $e";
    }
  }
}
