import 'package:conbun_production/Models/appointment_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentDetailsApis extends GetxController {
  RxBool isLoading = false.obs;

 Rx<AppointmentModel> appointmentDetailsModel = AppointmentModel.empty().obs;
 RxString endTime = ''.obs;
 RxString daysLeft = ''.obs;

  Future<String> getEndTime(String time, Duration minutes) async{
    DateFormat dateFormat = DateFormat('HH:mm:ss'); // Parse the time string in 'h:mm a' format
    // Parse the time string to a DateTime object
    DateTime dateTime = dateFormat.parse(time);
    // Add 30 minutes to the DateTime object
    DateTime newDateTime = dateTime.add(minutes);
    // Format the new DateTime object back to a string
    String newTimeString = dateFormat.format(newDateTime);
    endTime.value =  newTimeString;
    print(newTimeString);

    return newTimeString;
  }

  Future<void> formatDateForDisplay(String dateString) async {
    final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    final DateFormat outputFormat = DateFormat('MMM dd, yyyy'); // Or any other preferred format

    try {
      final DateTime date = inputFormat.parse(dateString);
      final DateTime now = DateTime.now();
      final Duration difference = date.difference(now);
      final int differenceInDays = difference.inDays;

      if (differenceInDays == 0) {
        daysLeft.value = 'Today';
      } else if (differenceInDays == 1) {
        daysLeft.value = 'Tomorrow';
      } else if (differenceInDays > 1 && differenceInDays <= 7) {
        daysLeft.value = '$differenceInDays days left';
      } else if (differenceInDays < 0) {
        daysLeft.value = 'Past date';
      } else {
        daysLeft.value = outputFormat.format(date);
      }
    } catch (e) {
      daysLeft.value = 'Invalid date';
    }
  }

}
