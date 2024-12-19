import 'dart:convert';
import 'package:conbun_production/Models/support_ticket_details_model.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constant.dart';


class SupportCenterApis extends GetxController {
  RxBool isLoading = false.obs;
  Rx<SupportTicketDetailsModel> ticketDetails = SupportTicketDetailsModel.empty().obs;

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id') ?? ''; // Set default value as empty string
    return userId;
  }
  Future<void> getTicketDetails(String ticketId) async {
    isLoading.value = true;
    String userId = await getUserId();
    print(userId);

    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}api/tickets/data/${ticketId}/User'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        final ticketData = json.decode(response.body);
        print(ticketData);
        ticketDetails.value = SupportTicketDetailsModel.fromJson(ticketData);
      } else {
        isLoading.value = false;

      }
    } catch (e) {
      isLoading.value = false;
      print('object ${e.toString()}');
    }
  }
}
