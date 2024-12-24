import 'dart:convert';
import 'package:conbun_production/Controllers/user_controller.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../Controllers/consultants_controller.dart';
import '../../../Controllers/service_category_controller.dart';
import '../../../Controllers/slider_controller.dart';
import '../../../utils/constant.dart';

class DashboardApis extends GetxController {
  RxBool isLoading = false.obs;

  RxString currentFilter = 'All'.obs;
  UserController userController = Get.put(UserController());

  Future<void> initController() async{
    isLoading.value = true;
    Get.put(ServiceCategoryController());
    Get.put(SliderController());
    Get.put(ConsultantsController());
    isLoading.value = false;
  }

  Future<void> changeFilter(String filterName)  async{
    currentFilter.value = filterName;
  }

  Future cancelAppointment(String userId, String appointmentId) async {
    isLoading.value = true;

    final requestBody = {
      'userid': userId,
      'appointmentid': appointmentId,
      'cancelled_by': 'User',
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/appointments/cancel'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      Map<String, dynamic> responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;
        // Check if the status is true
        if (responseBody['Error'] == 0) {
          String message = responseBody['message'];

          return responseBody;
        } else {
          // Handle the case where status is false or other error conditions
          isLoading.value = false;
          String message = responseBody['message'];
          return responseBody;
        }
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
