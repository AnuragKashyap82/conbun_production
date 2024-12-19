import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../utils/constant.dart';

class BookAppointmentApis extends GetxController {
  RxBool isLoading = false.obs;
  RxInt currentIndex = 0.obs;
  RxString selectedDuration = '0'.obs;
  RxString priceValue = ''.obs;
  RxString packageId = ''.obs;


  Future<String> getEndTime(String time, Duration minutes) async {
    // Create a DateFormat for parsing the input time
    DateFormat inputFormat = DateFormat('h:mm a'); // Input format (12-hour clock)

    // Create a DateFormat for the desired output format
    DateFormat outputFormat = DateFormat('HH:mm:ss'); // Output format (24-hour clock with seconds)

    // Parse the input time string to a DateTime object
    DateTime dateTime = inputFormat.parse(time);

    // Add the specified duration to the DateTime object
    DateTime newDateTime = dateTime.add(minutes);

    // Format the new DateTime object to the desired output format
    String newTimeString = outputFormat.format(newDateTime);

    print(newTimeString);
    return newTimeString; // Return the formatted time
  }
  Future<String> getStartTime(String time) async {
    // Create a DateFormat for parsing the input time
    DateFormat inputFormat = DateFormat('h:mm a'); // Input format (12-hour clock)

    // Create a DateFormat for the desired output format
    DateFormat outputFormat = DateFormat('HH:mm:ss'); // Output format (24-hour clock with seconds)

    // Parse the input time string to a DateTime object
    DateTime dateTime = inputFormat.parse(time);


    // Format the new DateTime object to the desired output format
    String newTimeString = outputFormat.format(dateTime);

    print(newTimeString);
    return newTimeString; // Return the formatted time
  }


  Future<void> clearPackage()async{
    currentIndex.value = 0;
    selectedDuration.value = '0';
    priceValue.value = '';
    packageId.value = '';
  }

  Future bookAppointment(
    String consultantId,
    String userId,
    String packageIdd,
    String sessionName,
    String sessionDetails,
    String appointmentDate,
    String startTime,
    String endTime,
  ) async {
    isLoading.value = true;

    final requestBody = {
      "consultantid": consultantId,
      "userid": userId,
      "packageid": packageIdd,
      "session_name": sessionName,
      "session_details": sessionDetails,
      "appointment_date": appointmentDate,
      "start_time": startTime,
      "end_time": endTime
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/appointments/create'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
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
