import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/constant.dart';

class LiveScreenApis extends GetxController {
  RxBool isLoading = false.obs;

  RxString currentLivePackage = ''.obs;
  RxString packageDuration = ''.obs;
  RxString startDate = ''.obs;
  RxString startTime = ''.obs;
  RxString errorMessage = ''.obs;

  Future<void> updateSelectedPackage(String packageId)  async{
    currentLivePackage.value = packageId;
  }

  Future<void> updateStartDate(String startDatee)  async{
    startDate.value = startDatee;
  }
  Future<void> updateStartTime(String startTimee)  async{
    startTime.value = startTimee;
  }
  Future<void> updateDuration(String duration)  async{
    packageDuration.value = duration;
  }

  Future createAppointment(
      String consultantId,
      String userId,
      String packageId,
      String appointmentDate,
      String startTime,
      String endTime,
      String channelToken,
      String channelName,
      ) async {
    isLoading.value = true;
    final requestBody = {
      'consultantid': consultantId,
      'userid': userId,
      'packageid': packageId,
      'appointment_date': appointmentDate,
      'start_time': startTime,
      'end_time': endTime,
      'channel_token': channelToken,
      'channel_name': channelName,
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/livecall/create'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        return responseBody;
      } else {
        isLoading.value = false;
        return responseBody;
      }
    } catch (e) {
      isLoading.value = false;
      return "An error occurred: $e";
    }
  }

  Future<String> getEndTime(String time, Duration minutes) async {
    // Create a DateFormat for parsing the input time
    DateFormat inputFormat = DateFormat('HH:mm:ss'); // Input format (24-hour clock with seconds)
   print('----------------------------------------------');
    try {
      // Parse the input time string to a DateTime object
      DateTime dateTime = inputFormat.parse(time);

      DateTime newDateTime = dateTime.add(minutes);

      String newTimeString = inputFormat.format(newDateTime);

      print(newTimeString);
      return newTimeString; // Return the formatted time
    } catch (e) {
      print("Error: $e");
      return "Invalid time";
    }
  }


}
