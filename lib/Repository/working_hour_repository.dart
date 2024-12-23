import 'dart:convert';
import 'package:conbun_production/Models/working_hour_model.dart';
import 'package:conbun_production/utils/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WorkingHourRepository extends GetxController {
  static WorkingHourRepository get instance => Get.find();

  Future<Map<String, dynamic>> fetchSchedules(String consultantId) async {
    final headers = {
      'Content-Type': 'application/json',
      'authtoken': Constant.authToken,
    };

   final  requestBody = {
      'consultantid': consultantId
    };

    final String requestBodyJson = jsonEncode(requestBody);

    final response = await http.post(
      Uri.parse('${Constant.baseUrl}api/consultants/getWorkingHours'),
      headers: headers,
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final bool status = responseBody['status'] ?? false;
      if (status) {
        final data = responseBody['data'] as Map<String, dynamic>;
        final Map<String, List<Schedule>> schedules = {};

        data.forEach((key, value) {
          schedules[key] = (value as List<dynamic>)
              .map((e) => Schedule.fromJson(e as Map<String, dynamic>))
              .toList();
        });

        return {'status': true, 'data': schedules};
      } else {
        return {'status': false, 'message': 'No data present'};
      }
    } else {
      throw Exception('Failed to load schedules');
    }
  }
}
