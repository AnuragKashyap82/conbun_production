import 'dart:convert';
import 'package:conbun_production/Models/appointment_model.dart';
import 'package:conbun_production/Models/reschedule_request_appointment_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class AppointmentsRepository extends GetxController {
  static AppointmentsRepository get instance => Get.find();

  Future<List<AppointmentModel>> getAllAppointment(String userId, String status) async {
    try {
      final requestBody = {
        "userid": userId,
        "start": "0",
        "limit": "100",
        "status": status
      };
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/appointments/get'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print("Upcoming appointents ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> appointmentData = json.decode(response.body);
        final List<AppointmentModel> allAppointment = appointmentData
            .map(
                (appointmentJson) => AppointmentModel.fromJson(appointmentJson))
            .toList();
        print('Response status code: ${allAppointment}');
        return allAppointment;
      } else {
        print("Failed to load allAppointment Json: ${response.body}");
        return [];

      }
    } catch (e) {
      print("Something went wrong: $e");
      return [];
    }
  }

  Future<List<AppointmentModel>> getAllAppointmentByLimit(String userId, String status, String limit) async {
    try {
      final requestBody = {
        "userid": userId,
        "start": "0",
        "limit": limit,
        "status": status
      };
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/appointments/get'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print('Response status code: ${response.statusCode}');
      print('Response status code getAllAppointment: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> appointmentData = json.decode(response.body);
        final List<AppointmentModel> allAppointment = appointmentData
            .map(
                (appointmentJson) => AppointmentModel.fromJson(appointmentJson))
            .toList();
        print('Response status code: ${allAppointment}');
        return allAppointment;
      } else {
        throw "Failed to load allAppointment Json: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }

  Future<List<RescheduleRequestAppointmentModel>> getAllRescheduleAppointmentRequest(String userId, String limit) async {
    try {

      final requestBody = {
        "userid": userId,
        "user_type": "User",
        "start": "0",
        "limit": limit
      };

      final String requestBodyJson = jsonEncode(requestBody);

      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/appointments/getRescheduleRequest'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );

      print('Response status code getAllRescheduleRequest: ${response.statusCode}');
      print('Response status code getAllRescheduleRequest: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> appointmentData =
            json.decode(response.body)['data'];
        final List<RescheduleRequestAppointmentModel> allAppointment =
            appointmentData
                .map((appointmentJson) =>
                    RescheduleRequestAppointmentModel.fromJson(appointmentJson))
                .toList();
        print('Response status code: ${allAppointment}');
        return allAppointment;
      } else {
        throw "Failed to load getAllRescheduleRequest Json: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}
