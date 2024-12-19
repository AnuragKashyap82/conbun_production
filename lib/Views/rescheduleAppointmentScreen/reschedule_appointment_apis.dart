import 'dart:convert';
import 'package:conbun_production/Models/appointment_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../utils/constant.dart';

class RescheduleAppointmentApis extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isClickable = true.obs;
  RxString selectedHour = ''.obs;
  RxInt selectedIndex = 0.obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<String> selectedFormattedDate = ''.obs;
  RxList<String> weekDays = [''].obs;

  ///RescheduleAppointment
  Rx<AppointmentModel> rescheduleAppointModel = AppointmentModel.empty().obs;
  RxString rescheduleReason = 'I don’t want to tell'.obs;
  RxString rescheduleReasonComment = ''.obs;

  RxMap<String, List<Map<String, String>>> weekDaySchedules =
      <String, List<Map<String, String>>>{}.obs;

  RxList<String> bookedTimeSlot = [
    '04:00 AM',
    '04:30 AM',
    '05:00 AM',
    '05:30 AM',
  ].obs;
  RxList<String> times = <String>[].obs;


  Future<void> clearDateAndTime() async {
    weekDays.clear();
    weekDaySchedules.clear();
    times.clear();
    selectedDay.value = DateTime.now();
    selectedHour.value = '';
  }

  Future<String> getEndTime(String time, Duration minutes) async{
    DateFormat dateFormat = DateFormat('h:mm a'); // Parse the time string in 'h:mm a' format

    // Parse the time string to a DateTime object
    DateTime dateTime = dateFormat.parse(time);

    // Add 30 minutes to the DateTime object
    DateTime newDateTime = dateTime.add(minutes);

    // Format the new DateTime object back to a string
    String newTimeString = dateFormat.format(newDateTime);

    print(newTimeString);
    return newTimeString;
  }

  Future rescheduleAppointment(
      String consultantId,
      String userId,
      String appointmentId,
      String appointmentDate,
      String startTime,
      String endTime,
      ) async {
    isLoading.value = true;

    final requestBody = {
      "userid": userId,
      "appointmentid": appointmentId,
      "appointment_date": appointmentDate,
      "user_type": "User",
      "start_time":startTime,
      "end_time": endTime,
      "reschedule_reason": rescheduleReason.value,
      "reschedule_comment": rescheduleReasonComment.value
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      print("working");
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/appointments/reschedule'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print("Response${response.toString()}");
      Map<String, dynamic> responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;
        isLoading.value = false;
        return responseBody;
      } else {
        isLoading.value = false;
        isLoading.value = false;
        return responseBody;
      }
    } catch (e) {
      isLoading.value = false;
      isLoading.value = false;
      return "An error occurred: $e";
    }
  }

  Future approveRejectRescheduleRequest(
      String rescheduleId,
      String appointmentId,
      String status
      ) async {
    isLoading.value = true;

    final requestBody = {
      "rescheduleid": rescheduleId,
      "appointmentid": appointmentId,
      "status": status,
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      print("working");
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/appointments/approveRescheduleRequest'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print("Response${response.toString()}");
      Map<String, dynamic> responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;
        isLoading.value = false;
        return responseBody;
      } else {
        isLoading.value = false;
        isLoading.value = false;
        return responseBody;
      }
    } catch (e) {
      isLoading.value = false;
      isLoading.value = false;
      return "An error occurred: $e";
    }
  }
}
