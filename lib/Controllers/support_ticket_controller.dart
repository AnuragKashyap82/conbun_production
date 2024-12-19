import 'package:conbun_production/Repository/support_ticket_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/support_ticket_model.dart';

class SupportTicketController extends GetxController {
  static SupportTicketController get instance => Get.find();

  final isLoading = false.obs;
  final _supportTicketRepository = Get.put(SupportTicketRepository());
  RxList<SupportTicketModel> allTickets = <SupportTicketModel>[].obs;

  @override
  void onInit() {
    fetchAllTickets();
    super.onInit();
  }
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id') ?? ''; // Set default value as empty string

    return userId;
  }
  Future<void> fetchAllTickets() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      print(userId);
      final coupons = await _supportTicketRepository.getAllTickets(userId);
      allTickets.assignAll(coupons);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
