import 'dart:convert';
import 'package:conbun_production/Models/support_ticket_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class SupportTicketRepository extends GetxController {
  static SupportTicketRepository get instance => Get.find();

  Future<List<SupportTicketModel>> getAllTickets(String userId) async {
    try {
      print(userId);
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}api/tickets/getTickets/${userId}/user'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
      );
      print('Response status code: ${response.statusCode}');
      print('Response status code supportTicket: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> ticketData = json.decode(response.body);
        final List<SupportTicketModel> ticket = ticketData
            .map((ticketJson) => SupportTicketModel.fromJson(ticketJson))
            .toList();
        print('Response status code: ${ticket}');
        return ticket;
      } else {
        throw "Failed to support ticket Json: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}

